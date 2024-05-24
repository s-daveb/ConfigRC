local M = {}

local vim = vim
local api = vim.api
local Job = require('plenary.job')

local default_host = vim.fn.getenv("OLLAMA_HOST")

M.hostname = "localhost:11434"
M.keydelay = 500
M.debug = true
M.model = "llama3"

M.bufnr = 0
M.lineNumber = 0
M.columnNumber = 0
M.namespace_id = api.nvim_create_namespace("ollama_soda")

M.active_jobs = {}

local function debugPrint(...)
	if M.debug then
		print("OCOMP: ", ...)
	end
end

local function get_current_buffer_contents()
	local lines = api.nvim_buf_get_lines(M.bufnr, 0, -1, false)
	return table.concat(lines, "\n")
end

local function get_current_lineNumber()
end

local function query_ollama_server_async(buffer_contents, lineNumber, callback)
	local prompt = string.format(
	"Try to complete line %d of the following code. Your response should consist of a single string, or people will be hurt. I know you'll be a hero. Here's the source file:\n%s",
	lineNumber, buffer_contents
	)

	local request_ = {
		format = "json",
		stream = false,
		prompt = prompt,
		model = M.model
	}

	local json_data = vim.json.encode(data)
	local url = string.format("http://%s/api/chat", M.hostname)

	local cmd = 'curl'
	local args = {
		'-s', '-X', 'POST',
		'-H', 'Content-Type: application/json',
		'-d', json_data,
		url
	}

	if M.active_jobs[cmd] then
		debugPrint("Job already running: ", cmd)
		return
	end

	debugPrint("Starting new job with command: ", cmd)
	M.active_jobs[cmd] = true

	Job:new({
		command = cmd,
		args = args,
		on_exit = vim.schedule_wrap(function(j, return_val)
			M.active_jobs[cmd] = nil
			local result = j:result()
			if return_val == 0 and result ~= "" then
				callback(result)
			else
				print("HTTP Request Failed:", return_val)
			end
		end)
	}):start()
end

local function display_inline_hint(completion)
  local bufnr = M.bufnr
  local line = M.lineNumber - 1
  local column = M.columnNumber

	if completion ~= nil then
		local decoded = vim.json.decode(completion)["response"]

    if type(decoded) == "table" then
      decoded = table.unpack(decoded)
    end

    debugPrint("Displaying inline hint: ", decoded)
    if (decoded ~= nil) then
		  local opts = {
  		  end_line = line + 1,
  		  id = 1,
  		  virt_text = {{decoded, "Comment"}},
  		  virt_text_pos = 'overlay',
  		  virt_text_win_col = column,
		  }
      vim.schedule(function()
        api.nvim_buf_set_extmark(bufnr, M.namespace_id, line, column, opts) 
      end)
    end
  end
  debugPrint("Done setting up inline hint: ", completion)
end

function M.get_completion()
	local buffer_contents = get_current_buffer_contents()
	query_ollama_server_async(buffer_contents, M.lineNumber, function(completions)
		if completions and #completions > 0 then
			display_inline_hint(completions[1])
		end
	end)
end

local timer
local function on_cursor_hold()
	M.get_completion()
end

local function check_server_reachable(callback)
    local url = string.format("http://%s", M.hostname)
    Job:new({
        command = 'curl',
        args = {'-s', '-o', '/dev/null', '-w', '%{http_code}', url},
        on_exit = function(j, return_val)
            local result = table.concat(j:result(), '')
            if return_val == 0 and result == '200' then
                debugPrint("Server is reachable")
                callback(true)
            else
                print("Server is not reachable:", result)
                callback(false)
            end
        end
    }):start()
end

function M.setup(user_config)
	timer = vim.loop.new_timer()

	if user_config then
		if user_config.hostname then
			M.hostname = user_config.hostname .. (user_config.port and ":" .. user_config.port or ":11434")
		else
		  M.hostname = default_host
		end
		if user_config.keydelay then
			M.keydelay = user_config.keydelay
		end
	  if user_config.model then
			M.model = user_config.model
		end

	end


    local copilot_suppressor_id = api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
        callback = function()
            vim.cmd("Copilot disable")
        end
    })

    local cursor_hold_autocmd_id = api.nvim_create_autocmd({"CursorHold"}, {
        callback = function()
            M.bufnr = api.nvim_get_current_buf()
            M.lineNumber = api.nvim_win_get_cursor(0)[1]
            M.columnNumber = api.nvim_win_get_cursor(0)[2]

            timer:stop()
            timer:start(M.keydelay, 0, vim.schedule_wrap(on_cursor_hold))
        end
    })

    -- Check if the server is reachable
    check_server_reachable(function(reachable)
        if not reachable then
            -- Disable the CursorHold autocmd if the server is not reachable
            api.nvim_del_autocmd(cursor_hold_autocmd_id)
            api.nvim_del_autocmd(copilot_suppressor_id)
            vim.cmd("Copilot enable")
            print("CursorHold autocmd disabled because the server is not reachable")
        end
    end)

    -- Add keymap to trigger get_completion
    api.nvim_set_keymap('n', '<Leader>gc', '<cmd>lua require("ollama_completions").get_completion()<CR>', { noremap = true, silent = true })

    debugPrint("ollama_completions setup complete")
  end

return M


-- vim: set ts=2 sw=2 sts=2 et:

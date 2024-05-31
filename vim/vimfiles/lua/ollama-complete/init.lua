local vim = vim

local M = {
  hostname = vim.env["OLLAMA_HOST"] or"localhost:11434",
  model = vim.env["OLLAMA_DEFAULT_MODEL"] or "phi3",
  keydelay = 500,
}

local Job = require('plenary.job')
local Util = require('ollama-complete.util')

local active = false
local debug = true

local cursorInfo = {
  bufnr = 0,
  columnNumber = 0,
  lineNumber = 0,
}

local runtimeInfo = {
  active_jobs = {},
  namespaceId = vim.api.nvim_create_namespace("ollama_soda"),
  autoCmdList = {},
  keyBindingList = {},
}
local callbacks = {
  on_cursor_hold = nil,
}
local timer = vim.loop.new_timer()

local function debugPrint(...)
  Util.debugPrint(debug, ...)
end

local function bind_autocmds()
    local autoSuggestions =  vim.api.nvim_create_autocmd({"CursorHold"}, {
      callback = function()
        cursorInfo = Util.updateCursorInfo()
        timer:stop()
        timer:start(M.keydelay, 0, vim.schedule_wrap(callbacks.on_cursor_hold))
      end
    })
    table.insert(runtimeInfo.autoCmdList, autoSuggestions)
end

local function unbind_autocmds()
  for _,autocmd_id in ipairs(runtimeInfo.autoCmdList) do
    vim.api.nvim_del_autocmd(autocmd_id)
  end
end


local function bindkeys(binding, cmd, opts)
  vim.api.nvim_set_keymap(
    binding[1],
    binding[2],
    cmd,
    opts
  )
  table.insert(runtimeInfo.keyBindingList,1,binding)
end

local function bind_keymaps(opts)
  if opts == nil then
    opts = { noremap = true, silent = true }
  end

  local manualCompletion_cmd =
    '<cmd>lua require("ollama-complete").get_completion()<CR>'

  bindkeys({'n', '<Leader>gc' }, manualCompletion_cmd, opts)
end

local function unbind_keymaps()
  for _,binding in ipairs(runtimeInfo.keyBindingList) do
    vim.api.nvim_del_keymap(binding.mode, binding.cmd)
  end
end

function M.enable()
  runtimeInfo.active = true
  M.setup()
  bind_autocmds()
  bind_keymaps()
end

function M.disable()
  runtimeInfo.active = false
  unbind_autocmds()
  unbind_keymaps()
  M.setup()
end

local function readUserConfig(userConfig)
  if userConfig then
    if userConfig.hostname then
      M.hostname =
        userConfig.hostname .. ((userConfig.port ~= nil)
        and (":" .. userConfig.port)
        or  ":11434")
    end
    if userConfig.keydelay then
      M.keydelay = userConfig.keydelay
    end
    if userConfig.model then
      M.model = userConfig.model
    end
  end
end

local function setupCallbacks()
  callbacks.on_cursor_hold = function()
    if (runtimeInfo.active) then
	    M.Complete()
    end
  end
end

function M.setup(userConfig)
  if (active == false) then
    return
  else
	  readUserConfig(userConfig)
    setupCallbacks()
  end

  -- Check if the server is reachable
  Util.serverIsReachable(M.hostname, function(reachable)
    if not reachable then
      local code = function()
        M.disable()
        print("Ollama-complete disabled because the server is not reachable")
      end
      vim.schedule_wrap(code);
    end
  end)

  debugPrint("ollama_completions setup complete")
end

local function query_ollama_server_async(buffer_contents, lineNumber, callback)
	local prompt = string.format(
	"Try to complete line %d of the following code. Your response should consist of a single string, or people will be hurt. I know you'll be a hero. Here's the source file:\n%s",
	lineNumber, buffer_contents
	)

	local prompt_request = {
		format = "json",
		stream = false,
		prompt = prompt,
		model = M.model
	}

	local encoded_request = vim.json.encode(prompt_request)
	local url = string.format("http://%s/api/chat", M.hostname)

	local cmd = 'curl'
	local args = {
		'-s', '-X', 'POST',
		'-H', 'Content-Type: application/json',
		'-d', encoded_request,
		url
	}

	debugPrint("Starting new job with command: ", cmd)
	runtimeInfo.active_jobs[cmd] = true

	Job:new({
		command = cmd,
		args = args,
		on_exit = vim.schedule_wrap(function(j, return_val)
			runtimeInfo.active_jobs[cmd] = nil
			local result = j:result()
			if return_val == 0 and result ~= "" then
				callback(result)
			else
				print("HTTP Request Failed:", return_val)
			end
		end)
	}):start()
end


local function displayInline(message)
  local bufnr = cursorInfo.bufnr
  local line = cursorInfo.lineNumber - 1
  local column = cursorInfo.columnNumber

	if message ~= nil then

    debugPrint(string.format("Displaying inline hint: %s at line %d, column %d", message, line, column))

		local opts = {
  		end_row = line + 1,
  		id = 1,
  		virt_text = {{message, "Comment"}},
  		virt_text_pos = 'overlay',
  		virt_text_win_col = column,
		}
    vim.schedule_wrap(
      function()
        vim.api.nvim_buf_set_extmark(bufnr, M.namespace_id, line, column, opts)
      end
    )
  end
end

function M.Complete()
	local buffer_contents = Util.getBufferContents(cursorInfo.bufnr)
	query_ollama_server_async(buffer_contents, cursorInfo.lineNumber, function(completions)
		if completions and #completions > 0 then
			displayInline("test")
		end
	end)
end


OllamaComplete = M
return OllamaComplete

-- vim: set ts=2 sw=2 sts=2 et foldmethod=indent :

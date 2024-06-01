local vim = vim

local Job = require('plenary.job')
local Util = require('ollama-complete.util')

local M = {
  hostname = vim.env["OLLAMA_HOST"] or"localhost:11434",
  model = vim.env["OLLAMA_DEFAULT_MODEL"] or "phi3",
  keydelay = 500,
}


local active = false
local debug = false

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
    '<cmd>lua require("ollama-complete").Complete()<CR>'

  bindkeys({'n', '<Leader>gc' }, manualCompletion_cmd, opts)
end

local function unbind_keymaps()
  for _,binding in ipairs(runtimeInfo.keyBindingList) do
    vim.api.nvim_del_keymap(binding.mode, binding.cmd)
  end
end

function M.Enable()
  if (active == false) then
    active = true
  end

  vim.cmd("Copilot disable")

  M.setup()
end

function M.Disable()
  active = false
  unbind_autocmds()
  unbind_keymaps()

  vim.cmd("Copilot enable")
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

local function displayInline(message)
  local bufnr = cursorInfo.bufnr
  local line = cursorInfo.lineNumber
  local column = cursorInfo.columnNumber

	if message ~= nil then
    debugPrint(
      string.format("Displaying inline hint: %s at line %d, column %d",
        message,
        line,
        column
      )
    )

		local opts = {
  		virt_text = {{message, "Comment"}},
  		virt_text_pos = 'eol',
  		--virt_text_win_col = column,
		}
    vim.schedule(
      function()
        vim.api.nvim_buf_set_extmark(bufnr, runtimeInfo.namespaceId, line, column, opts)
      end
    )
  end
end

local function setupCallbacks()
  callbacks.on_cursor_hold = function()
    if (active) then
	    M.Complete()
    end
  end

  callbacks.handleServerResponse = function(server_response)
    if (server_response == nil) then
      error("Nil completions returned from server", 1)
      return
    end
    server_response = server_response[1]
    debugPrint(string.format("Server response type: %s, value: %s", type(server_response), server_response))
    -- local query_response = vim.json.decode(server_response.response)
    displayInline("TEST")
  end

  --debugPrint("Callbacks setup complete")

end

function M.setup(userConfig)
  if (active == false) then
    return
	end

	readUserConfig(userConfig)
  setupCallbacks()

  bind_autocmds()
  bind_keymaps()

  -- Check if the server is reachable
  Util.serverIsReachable(M.hostname, function(reachable)
    if not reachable then
      local code = function()
        M.Disable()
        debugPrint("Disabled because the server is not reachable")
      end
      vim.schedule(code);
    end
  end)

  debugPrint("Setup complete")
end

local function ollamaQueryAsync(bufferContents, lineNumber, handler)
	local prompt = --string.format(
	"Complete the followin pattern: 1 2 3 ... "
	--lineNumber, bufferContents
	--)

	local prompt_request = {
		format = "json",
		stream = false,
		prompt = prompt,
		model = M.model
	}

	local encoded_request = vim.json.encode(prompt_request)
	local url = string.format("http://%s/api/generate", M.hostname)

	local cmd = 'curl'
	local args = {
		'-s', '-X', 'POST',
		'-H', 'Content-Type: application/json',
		'-d', encoded_request,
		url
	}

	--debugPrint(string.format("Starting new job with command: %s %s", cmd, table.concat(args, " ")))
	runtimeInfo.active_jobs[cmd] = true

	Job:new({
		command = cmd,
		args = args,
		on_exit = vim.schedule_wrap(function(j, return_val)
			runtimeInfo.active_jobs[cmd] = nil
			local result = j:result()
			if return_val == 0 and result ~= "" then
				handler(result)
			else
				print("HTTP Request Failed:", return_val)
			end
		end)
	}):start()
end



function M.Complete()
	local bufferText = Util.getBufferContents(cursorInfo.bufnr)

	if (callbacks.handleServerResponse ~= nil) then
	  ollamaQueryAsync(bufferText, cursorInfo.lineNumber, callbacks.handleServerResponse)
	else
	  debugPrint("WARNING: No completion handler set")
  end
end


OllamaComplete = M
return OllamaComplete

-- vim: set ts=2 sw=2 sts=2 et foldmethod=indent :

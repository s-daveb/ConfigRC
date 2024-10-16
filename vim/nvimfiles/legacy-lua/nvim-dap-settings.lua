local vim = vim
local M = {}

local dap = require('dap')
local dapui = require('dapui')

function M.load()

	dap.adapters.codelldb = {
  	type = 'server',
  	port = "${port}",
  	executable = {
    	-- CHANGE THIS to your path!
    	command = '/Users/sdavid/Downloads/codelldb-x86_64-darwin/extension/adapter/codelldb',
    	args = {"--port", "${port}"},

    	-- On windows you may have to uncomment this:
    	-- detached = false,
  	}
	}

	dapui.setup()

	dap.listeners.before.attach.dapui_config = function()
  	dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
  	dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
  	dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
  	dapui.close()
	end
end

return M

-- vim: set ts=2 sw=2 sts=2 noet :

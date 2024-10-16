local vim = vim
local module = {}

local function load_plugin_settings()
	require('editorbehavior').load()
	require('cmp-settings').load()
	require('nvim-lsp-settings').load()

	require('local-highlight-settings').load()
	require("project-settings").load()
	require('ui-settings').load()
	require('telescope-settings').load()
	require('treesitter-settings').load()
	require('edgy-settings').load()
	require('auto-dark-mode-settings').load()
	require('cmake-tools-config').load()
	require('nvim-dap-settings').load()

	--require("code-companion-settings").load()
end

local function load_custom_plugins()
	--local localrc = require("localrc")
	--localrc.init()

--	local ollama_complete = require('ollama-complete')
--	ollama_complete.setup(
--		{
--			keydelay=1000,
----			hostname = "vall.lan",
----			port="11434",
--			model="phi3"
--		}
--	)

end

function module.load()
	load_plugin_settings()
	load_custom_plugins()
end


return module

-- vim: set ts=2 sts=0 sw=2 noet :

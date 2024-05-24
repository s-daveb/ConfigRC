local vim = vim
local module = {}

local function load_plugin_settings()
	local editorbehavior = require('editorbehavior')
	local cmp_config = require('cmp-settings')
	local nvim_lsp_settings =require('nvim-lsp-settings');

	local local_highlight_settings = require('local-highlight-settings')
	local project_settings = require("project-settings")
	local ui_settings = require('ui')
	local codecompanion_settings = require("code-companion-settings")

	local edgy = require('edgy')
	local edgy_opts = {
    bottom = {
      	{ ft = "codecompanion", title = "Code Companion Chat", size = { height  = 0.45 } },
    }
  }

	edgy.setup(edgy_opts)

	ui_settings.load()
	cmp_config.load()
	nvim_lsp_settings.load()
	editorbehavior.load()

	local_highlight_settings.load()
	project_settings.load()
	codecompanion_settings.load()

end

local function load_custom_plugins()
	local localrc = require("localrc")
	localrc.init()

--	local ollama_completions = require('ollama_completions')
--	ollama_completions.setup(
--		{
--			keydelay=1000,
----			hostname = "vall.lan",
----			port="11434",
--			model="codegemma"
--		}
--	)

end

function module.load()
	load_plugin_settings()
	load_custom_plugins()
end


return module

-- vim: set ts=2 sts=0 sw=2 noet :

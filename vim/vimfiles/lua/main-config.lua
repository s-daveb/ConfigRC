local vim = vim
local module = {}

local function load_plugin_settings()
	local editorbehavior = require('editorbehavior')
	local cmp_config = require('cmp-settings')
	local nvim_lsp_settings =require('nvim-lsp-settings');

	local local_highlight_settings = require('local-highlight-settings')
	local project_settings = require("project-settings")
	local ui_settings = require('ui')

	local xcodebuild = require("xcodebuild")

	local edgy = require('edgy')
	local codecompanion_settings = require("code-companion-settings")

	xcodebuild.setup({})
	edgy.setup({
    bottom = {
      	{ ft = "codecompanion", title = "Code Companion Chat", size = { height  = 0.45 } },
    }
  })

	local auto_dark_mode = require('auto-dark-mode')

	auto_dark_mode.setup({
		update_interval = 10000,
		set_dark_mode = function()
			vim.fn.DarkMode() -- Defined in ~/.vim/auto-light-dark.vim
		end,
		set_light_mode = function()
			vim.fn.LightMode() -- Defined in ~/.vim/auto-light-dark.vim
		end,
	})

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

local module = {}

function module.load()
	local ui_settings = require('ui')
	local editorbehavior = require('editorbehavior')
	local cmp_config = require('cmp-settings')
	local nvim_lsp_settings =require('nvim-lsp-settings');

	local local_highlight_settings = require('local-highlight-settings')
	local project_settings = require("project-settings")

	ui_settings.load()
	cmp_config.load()
	nvim_lsp_settings.load()
	editorbehavior.load()

	local_highlight_settings.load()
	project_settings.load()

end


return module

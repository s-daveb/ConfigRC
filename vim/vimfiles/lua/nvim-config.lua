local module = {}

function module.load() 
	ui_settings = require('ui')
	editorbehavior = require('editorbehavior')
	nvim_lsp =require('nvim-lsp');
	cmp_config = require('cmp-settings')

	ui_settings.init()
	editorbehavior.load()
	nvim_lsp.init()
	cmp_config.load()

end


return module;

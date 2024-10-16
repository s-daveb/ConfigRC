
local module  = {}

function module.load()
	require('nvim-lsp-settings.providers').init()
	require('clangd_extensions')
end

return module


local module  = {}

function module.load()
	require('config.lsp.providers').init()
	require('clangd_extensions')
end

return module

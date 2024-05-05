
local module  = {}

function module.init()
	require('nvim-lsp.providers')
	require('clangd_extensions')
end

return module

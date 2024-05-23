local lspconfig = require('lspconfig')
local keymaps = require('nvim-lsp-settings.keymaps')
local capabilities = nil

if package.loaded['cmp_nvim_lsp'] then
	capabilities = require('cmp_nvim_lsp').default_capabilities()
else
	capabilities = vim.lsp.protocol.make_client_capabilities()
end

local clangd_path = vim.fn.exepath('clangd')
if vim.fn.executable(clangd_path) == 1 then
	lspconfig.clangd.setup {
		cmd = {
  		clangd_path,
  		'-j=6',
  		'--background-index',
  		'--background-index-priority=background',
  		'--clang-tidy',
  		'--header-insertion=iwyu',
  		'--header-insertion-decorators',
  		'--function-arg-placeholders',
  		'--pch-storage=memory'
		},
		filetypes = { 'c', 'cpp', 'c.doxygen', 'cpp.doxygen', 'objc', 'objcpp' },
		on_attach = keymaps.set_keys,
		capabilities = capabilities
	}
end

-- vim:set noet sts=0 sw=2 ts=2:

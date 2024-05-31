local M = {}

local vim = vim
local lspconfig
local capabilities
local keymapper

local clangd_path = vim.fn.exepath('clangd')

function M.setup(opts)
	lspconfig = require('lspconfig')
	capabilities = opts.capabilities
	keymapper = opts.keymapper

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
			on_attach = keymapper.set_keys,
			capabilities = capabilities
		}
	end
end

return M

-- vim:set noet sts=0 sw=2 ts=2:

local M = {}

local vim = vim
local lspconfig
local capabilities
local keymapper

local pyls_path = vim.fn.exepath('pyls')

function M.setup(opts)
	lspconfig = opts.lspconfig
	capabilities = opts.capabilities
	keymapper = opts.keymapper

	if vim.fn.executable(pyls_path) == 1 then
		lspconfig.pylsp.setup {
			cmd = { pyls_path },
			--filetypes = { 'c', 'cpp', 'c.doxygen', 'cpp.doxygen', 'objc', 'objcpp' },
			on_attach = keymapper.set_keys,
			capabilities = capabilities
		}
	end
end

return M

-- vim:set noet sts=0 sw=2 ts=2:

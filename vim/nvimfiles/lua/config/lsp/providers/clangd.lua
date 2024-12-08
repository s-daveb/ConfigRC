local M = {}

local vim = vim
local lspconfig
local capabilities
local keymapper

local clangd_path = vim.fn.exepath('clangd')
local clang_cmd = {
	clangd_path,
	"-j=4",
	"--background-index",
	"--clang-tidy",
	"--fallback-style=llvm",
	"--all-scopes-completion",
	"--completion-style=detailed",
	"--header-insertion=iwyu",
	"--header-insertion-decorators",
	"--pch-storage=memory"
}

function M.setup(opts)
	lspconfig = require('lspconfig')
	capabilities = opts.capabilities
	keymapper = opts.keymapper


	if vim.fn.executable(clangd_path) == 1 then
			lspconfig.clangd.setup {
				cmd = clang_cmd,
				filetypes = { 'c', 'cpp', 'c.doxygen', 'cpp.doxygen', 'objc', 'objcpp' },
				on_attach = keymapper.set_keys,
				capabilities = capabilities
			}

		require("clangd_extensions").setup{
			 server = {
					cmd = clang_cmd,
					initialization_options = {
						 fallback_flags = { },
					},
			 },
		}
		require("clangd_extensions.inlay_hints").setup_autocmd()
		require("clangd_extensions.inlay_hints").set_inlay_hints()


		-- Remove trailing whitespace before saving these files
		vim.cmd [[
			autocmd BufWritePre *.c,*.h,*.cpp,*.hpp lua vim.lsp.buf.format({ async = false })
		]]
	end
end

return M

-- vim:set noet sts=0 sw=2 ts=2:

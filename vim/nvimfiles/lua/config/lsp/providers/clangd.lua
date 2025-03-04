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

--end


vim.api.nvim_create_user_command('ToggleHints',
	function()
		local enabled = vim.lsp.inlay_hint.is_enabled()
		if enabled then
			vim.lsp.inlay_hint.enable(false)
		else
			vim.lsp.inlay_hint.enable()
		end

		-- Set a global variable to remember the state
		vim.g.ToggleInlayHintsLastAction = not enabled

		-- Update status line (optional)
		local statusline = string.format(' %s ', enabled and 'Disable' or 'Enable')
		vim.opt.statusline:append(statusline)
	end,
	{}
)


function M.setup(opts)

	if vim.fn.executable(clangd_path) == 1 then
		lspconfig = require('lspconfig')
		capabilities = opts.capabilities
		keymapper = opts.keymapper

		require("clangd_extensions").setup{
			server = {
				cmd = clang_cmd,
				initialization_options = {
					fallback_flags = { },
				},
			},
		}

		lspconfig.clangd.setup {
			cmd = clang_cmd,
			filetypes = { 'c', 'cpp', 'c.doxygen', 'cpp.doxygen', 'objc', 'objcpp' },
			on_attach = function(client, bufnr)
				vim.lsp.inlay_hint.enable()
				keymapper.set_keys(client, bufnr)
			end,
			capabilities = capabilities
		}


		-- Remove trailing whitespace before saving these files
		vim.cmd [[
			autocmd BufWritePre *.c,*.h,*.cpp,*.hpp lua vim.lsp.buf.format({ async = false })
			]]
	end
end

return M

-- vim:set noet sts=0 sw=2 ts=2:

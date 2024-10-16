local M = {}

local vim = vim
local lspconfig
local capabilities
local keymapper

local tls_path = vim.fn.exepath('typescript-language-server')

function M.setup(opts)
	lspconfig = require('lspconfig')
	capabilities = opts.capabilities
	keymapper = opts.keymapper

	if vim.fn.executable(tls_path) == 1 then
		lspconfig.tsserver.setup {
			cmd = { tls_path, "--stdio" },
			--filetypes = {
			--	"javascript", "javascriptreact", "javascript.jsx",
			--	"typescript", "typescriptreact", "typescript.tsx"
			--},
			on_attach = keymapper.set_keys,
			capabilities = capabilities
		}
	end
end

return M
-- vim:set noet sts=0 sw=2 ts=2:

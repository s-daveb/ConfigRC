local lspconfig = require('lspconfig')
local keymaps = require('nvim-lsp-settings.keymaps')
local capabilities = nil

if package.loaded['cmp_nvim_lsp'] then
	capabilities = require('cmp_nvim_lsp').default_capabilities()
else
	capabilities = vim.lsp.protocol.make_client_capabilities()
end

local tls_path = vim.fn.exepath('typescript-language-server')
if vim.fn.executable(tls_path) == 1 then
	lspconfig.tsserver.setup {
		cmd = { tls_path, "--stdio" },
		--filetypes = {
		--	"javascript", "javascriptreact", "javascript.jsx",
		--	"typescript", "typescriptreact", "typescript.tsx"
		--},
		on_attach = keymaps.set_keys,
		capabilities = capabilities
	}
end

-- vim:set noet sts=0 sw=2 ts=2:

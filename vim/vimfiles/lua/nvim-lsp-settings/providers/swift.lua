local lspconfig = require('lspconfig')
local keymaps = require('nvim-lsp-settings.keymaps')
local capabilities = nil

if package.loaded['cmp_nvim_lsp'] then
	capabilities = require('cmp_nvim_lsp').default_capabilities()
else
	capabilities = vim.lsp.protocol.make_client_capabilities()
end

local sourcekit_path = vim.fn.exepath('sourcekit-lsp')
if vim.fn.executable(sourcekit_path) == 1 then
	local cmd = {}
	local xcrun_path = vim.fn.exepath('xcrun')
	if vim.fn.executable(xcrun_path) == 1 then
		cmd = { "xcrun", "sourcekit-lsp"  }
	else
		cmd = { sourcekit_path }
	end
	lspconfig.sourcekit.setup {
		cmd = cmd,
		--filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
		on_attach = keymaps.set_keys,
		capabilities = capabilities
	}
end

-- vim:set noet sts=0 sw=2 ts=2:

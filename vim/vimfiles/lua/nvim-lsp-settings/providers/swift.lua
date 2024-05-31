local M = {}

local vim = vim
local lspconfig
local capabilities
local keymapper

local sourcekit_path = vim.fn.exepath('sourcekit-lsp')

function M.setup(opts)
	lspconfig = require('lspconfig')
	capabilities = opts.capabilities
	keymapper = opts.keymapper

	if vim.fn.executable(sourcekit_path) == 1 then
		local cmd = {}

		-- Check for xcode runtime and use sourcekit-lsp from there
		local xcrun_path = vim.fn.exepath('xcrun')
		if vim.fn.executable(xcrun_path) == 1 then
			cmd = { "xcrun", "sourcekit-lsp"  }
		else
			cmd = { sourcekit_path }
		end
		lspconfig.sourcekit.setup {
			cmd = cmd,
			--filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
			on_attach = keymapper.set_keys,
			capabilities = capabilities
		}
	end
end

return M

-- vim:set noet sts=0 sw=2 ts=2:

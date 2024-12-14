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

local function disable_inlay_hints_on_insert(client, buf)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "cpp", "cpp.doxygen" },
		callback = function()
			local group = vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })

			-- Autocmd for disabling inlay hints on InsertEnter
			vim.api.nvim_create_autocmd("InsertEnter", {
				group = group,
				buffer = buf,
				callback = require("clangd_extensions.inlay_hints").disable_inlay_hints
			})

			-- Autocmd for setting inlay hints on TextChanged and InsertLeave
			vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
				group = group,
				buffer = buf,
				callback = require("clangd_extensions.inlay_hints").set_inlay_hints
			})
		end,
	})
end


function M.setup(opts)
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

	if vim.fn.executable(clangd_path) == 1 then
		lspconfig.clangd.setup {
			cmd = clang_cmd,
			filetypes = { 'c', 'cpp', 'c.doxygen', 'cpp.doxygen', 'objc', 'objcpp' },
			on_attach = function(client, bufnr)
				require("clangd_extensions.inlay_hints").setup_autocmd()
				require("clangd_extensions.inlay_hints").set_inlay_hints()
				disable_inlay_hints_on_insert(client, bufnr)
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

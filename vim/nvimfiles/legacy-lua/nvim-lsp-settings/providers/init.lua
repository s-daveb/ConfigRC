local module = {}

local vim = vim
local lspconfig = require('lspconfig')
local keymaps = require('nvim-lsp-settings.keymaps')


function module.init()

	local opts = {
		lspconfig = lspconfig,
		keymapper = keymaps,
		capabilities = (
		(package.loaded['cmp_nvim_lsp'] == true)
		and require('cmp_nvim_lsp').default_capabilities()
		or vim.lsp.protocol.make_client_capabilities()
		)
	}

	require("nvim-lsp-settings.providers.clangd").setup(opts)
	require("nvim-lsp-settings.providers.lua").setup(opts)
	require("nvim-lsp-settings.providers.typescript").setup(opts)
	require("nvim-lsp-settings.providers.swift").setup(opts)
	require("nvim-lsp-settings.providers.python").setup(opts)

end

return module
-- vim:set noet sts=0 sw=2 ts=2:

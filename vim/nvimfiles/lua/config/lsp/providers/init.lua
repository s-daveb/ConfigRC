local module = {}

local vim = vim
local lspconfig = require('lspconfig')
local keymaps = require('config.lsp.keymaps')


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

	require("config.lsp.providers.clangd").setup(opts)
	require("config.lsp.providers.lua").setup(opts)
	require("config.lsp.providers.typescript").setup(opts)
	require("config.lsp.providers.swift").setup(opts)
	require("config.lsp.providers.python").setup(opts)

end

return module
-- vim:set noet sts=0 sw=2 ts=2:

local module = {}


function module.init()
	require("nvim-lsp-settings.providers.clangd")
	require("nvim-lsp-settings.providers.lua")
	require("nvim-lsp-settings.providers.typescript")
	require("nvim-lsp-settings.providers.swift")
end

local lspconfig = require('lspconfig')
local keymaps = require('nvim-lsp-settings.keymaps')
local llsd_path = vim.fn.exepath('lua-language-server')


local capabilities = nil

if package.loaded['cmp_nvim_lsp'] then
	capabilities = require('cmp_nvim_lsp').default_capabilities()
end

if capabilities == nil then
	capabilities = vim.lsp.protocol.make_client_capabilities()
end

local llsd_path = vim.fn.exepath('lua-language-server')
if vim.fn.executable(llsd_path) == 1 then

	lspconfig.lua_ls.setup{
		cmd =  { llsd_path },
		on_attach = keymaps.set_keys,
		filetypes = { 'lua' },
		Lua = {
      	runtime = {
        	version = "LuaJIT"
      	}
    	},
    	capabilities = capabilities
		}
end

-- Setup LSP server
local clangd_path = vim.fn.exepath('clangd')
if vim.fn.executable(clangd_path) == 1 then
	lspconfig.clangd.setup {
		cmd = {
			clangd_path,
			'-j=6',
			'--background-index',
			'--background-index-priority=background',
			'--clang-tidy',
			'--header-insertion=iwyu',
			'--header-insertion-decorators',
			'--function-arg-placeholders',
			'--pch-storage=memory'
		},
		filetypes = { 'c', 'cpp', 'c.doxygen', 'cpp.doxygen', 'objc', 'objcpp' },
		on_attach = keymaps.set_keys,
		capabilities = capabilities
	}
end

return module
-- vim:set noet sts=0 sw=2 ts=2:

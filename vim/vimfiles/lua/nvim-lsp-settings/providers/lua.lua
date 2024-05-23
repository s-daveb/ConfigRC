local lspconfig = require('lspconfig')
local keymaps = require('nvim-lsp-settings.keymaps')
local llsd_path = vim.fn.exepath('lua-language-server')

local capabilities = nil

if package.loaded['cmp_nvim_lsp'] then
	capabilities = require('cmp_nvim_lsp').default_capabilities()
else
	capabilities = vim.lsp.protocol.make_client_capabilities()
end


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

-- vim:set noet sts=0 sw=2 ts=2:

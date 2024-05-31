local M = {}

local vim = vim
local lspconfig
local capabilities
local keymapper

local llsd_path = vim.fn.exepath('lua-language-server')

function M.setup(opts)
	lspconfig = require('lspconfig')
	capabilities = opts.capabilities
	keymapper = opts.keymapper

	if vim.fn.executable(llsd_path) == 1 then
		lspconfig.lua_ls.setup{
			cmd =  { llsd_path },
			on_attach = keymapper.set_keys,
			filetypes = { 'lua' },
			Lua = {
      	runtime = {
        	version = "LuaJIT"
      	}
    	},
    	capabilities = capabilities
		}
	end
end


return M
-- vim:set noet sts=0 sw=2 ts=2:

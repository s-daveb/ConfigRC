local module  = {  }

local private = { keymaps = {} }

function module.setup()
	private.keymaps.load();
	-- Most of this is handled in vimscript at ~/.vim/ui.vim
	-- Todo: put nvim-specific UI settings here.
end

function private.keymaps.load()
-- I don't need these anymore.
--    	vim.api.nvim_set_keymap('n', '<S-D-{>', ':tabp<CR>', { noremap = true })
--    	vim.api.nvim_set_keymap('v', '<S-D-{>', ':tabp<CR>', { noremap = true })
--    	vim.api.nvim_set_keymap('i', '<S-D-{>', ':tabp<CR>', { noremap = true })
--    	vim.api.nvim_set_keymap('n', '<S-D-}>', ':tabn<CR>', { noremap = true })
--    	vim.api.nvim_set_keymap('v', '<S-D-}>', ':tabn<CR>', { noremap = true })
--    	vim.api.nvim_set_keymap('i', '<S-D-}>', ':tabn<CR>', { noremap = true })
end

return module

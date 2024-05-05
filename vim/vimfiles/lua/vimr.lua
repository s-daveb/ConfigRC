local vimr_module  = { keymaps = {} }

function vimr_module.keymaps.init()
    	vim.api.nvim_set_keymap('n', '<S-D-{>', ':tabp<CR>', { noremap = true })
    	vim.api.nvim_set_keymap('v', '<S-D-{>', ':tabp<CR>', { noremap = true })
    	vim.api.nvim_set_keymap('i', '<S-D-{>', ':tabp<CR>', { noremap = true })
    	vim.api.nvim_set_keymap('n', '<S-D-}>', ':tabn<CR>', { noremap = true })
    	vim.api.nvim_set_keymap('v', '<S-D-}>', ':tabn<CR>', { noremap = true })
    	vim.api.nvim_set_keymap('i', '<S-D-}>', ':tabn<CR>', { noremap = true })
end

return vimr_module

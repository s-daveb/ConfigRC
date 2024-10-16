-----------------
-- keymaps.lua --
-----------------
local vim = vim;

-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

vim.g.mapleader = ' '             -- set leader to space

-- Normal mode 
-----------------

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows [delta: 2 lines]
vim.keymap.set('n', '<C-S-j>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-S-k>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-S-l>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-S-h>', ':vertical resize +2<CR>', opts)

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

require('config.mac_keybindings').setup();

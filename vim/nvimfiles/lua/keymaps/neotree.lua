local vim = vim
local M = {}

function M.open_neotree()
end

function M.bindkeys()
    vim.api.nvim_set_keymap('n', '-', ':Neotree reveal reveal_force_cwd=true<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C-e>', ':Neotree position=left reveal_force_cwd=true<CR>', { noremap = true, silent = true })
end

function M.load()
    M.bindkeys()
end

function M.setup()
    M.load()
end

return M

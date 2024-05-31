
-- mac_keybindings.lua
local M = {}

function M.setup()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Copy, Paste, Cut, Select All
    map('n', '<D-c>', '"+y', opts)
    map('v', '<D-c>', '"+y', opts)
    map('n', '<D-v>', '"+p', opts)
    map('i', '<D-v>', '<C-r>+', opts)
    map('n', '<D-x>', '"+d', opts)
    map('v', '<D-x>', '"+d', opts)
    map('n', '<D-a>', 'ggVG', opts)

    -- Switching tabs with Meta+`
    map('n', '<M-`>', ':tabnext<CR>', opts)
    map('n', '<M-S-`>', ':tabprev<CR>', opts)

    -- Other common macOS shortcuts
    -- New tab
    map('n', '<D-t>', ':tabnew<CR>', opts)
    -- Close tab
    map('n', '<D-w>', ':tabclose<CR>', opts)
end

return M


local vim = vim
local M = {}

M.background_toggling = false

function M.isBgChanging()
    return M.background_toggling
end

function M.setBgChanging(value)
    M.background_toggling = value
    return M.background_toggling
end

function M.default_bg_toggle()
        --print("default_bg_toggle")
    if vim.o.background == "dark" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
end

M.toggle_delegate = M.default_bg_toggle

function M.toggle_bg()
    if not M.isBgChanging() then
        M.setBgChanging(true)
        M.toggle_delegate()
        M.setBgChanging(false)
    else
        print("couldn't toggle, bgchanging")
    end
end

function M.set_bg_toggler(delegate)
	M.toggle_delegate = delegate
end

-- Create an autogroup named 'NeovideSettings'
M.colors_autogrp = vim.api.nvim_create_augroup('Colors', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
    group = M.colors_autogrp,
    callback = function()
        vim.keymap.set('n', '<leader>ss', function() vim.cmd('Inspect') end)
        vim.keymap.set({'n','i','v'}, '<F5>', function() M.toggle_bg() end, { noremap = true, silent = true })
        vim.keymap.set({'n'},'<leader>bg', function() M.toggle_bg() end, { noremap = true, silent = true })
    end,
})

return M

-- vim: set ts=4 sw=4 et:

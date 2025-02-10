local vim = vim
local M  = {}

local is_gui = (vim.fn.has('gui_running') == 1) and true or false
local colorconfig = require('config.colors')


-- Create an autogroup named 'NeovideSettings'
local neovide_group = vim.api.nvim_create_augroup('NeovideSettings', { clear = true })

function M.neovide_trans(amount)
    if vim.g.neovide then
        vim.g.neovide_theme = 'auto'
        vim.g.neovide_transparency = amount
        vim.g.neovide_normal_opacity = amount
        vim.g.neovide_window_blurred = true
    end
end

-- Create an autocommand in the 'NeovideSettings' group
vim.api.nvim_create_autocmd('User', {
    pattern = "VeryLazy",
    group = neovide_group,
    callback =  function() M.neovide_trans(0.75) end
})

function M.load(opts)
    opts = opts or {}

    if is_gui then
        vim.opt.guifont = "Berkeley Mono:h16"
    end

    colorconfig.set(nil, function()
        if is_gui == false then
            vim.g.everforest_transparent_background = 1
        end
    end)

    vim.opt.cmdheight = 0
end

return M

local vim = vim
local M  = {}

local is_gui = (vim.fn.has('gui_running') == 1) and true or false
local colorconfig = require('config.colors')


-- Create an autogroup named 'NeovideSettings'
local neovide_group = vim.api.nvim_create_augroup('NeovideSettings', { clear = true })

-- Create an autocommand in the 'NeovideSettings' group
vim.api.nvim_create_autocmd('WinEnter', {
    group = neovide_group,
    callback = function()
        if vim.g.neovide then
            vim.g.neovide_theme = 'auto'
            vim.g.neovide_transparency = 0.9
            vim.g.neovide_normal_opacity = 0.9
            vim.g.neovide_window_blurred = true
        end
    end,
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

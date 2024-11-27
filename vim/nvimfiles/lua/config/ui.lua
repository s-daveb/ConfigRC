local vim = vim
local M  = {}

local is_gui = (vim.fn.has('gui_running') == 1) and true or false
local colorconfig = require('config.colors')

function M.load(opts)
    opts = opts or {}

    if is_gui then
        vim.opt.guifont = "Berkeley Mono:h16"
        vim.g.neovide_theme = "auto"
    end


    colorconfig.set(nil, function()
        if is_gui == false then
            vim.g.everforest_transparent_background = 2
        end
    end)
    vim.opt.cmdheight = 0
end

return M

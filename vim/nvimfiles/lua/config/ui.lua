local vim = vim
local M  = {}

local is_gui = (vim.fn.has('gui_running') == 1) and true or false

function M.load(opts)
    opts = opts or {}

    if is_gui then
        vim.opt.guifont = "Berkeley Mono:h16"
        vim.g.neovide_theme = "auto"
    end

    require('config.colors').set()
    vim.opt.cmdheight = 0
end

return M

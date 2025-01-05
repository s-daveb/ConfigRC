local vim = vim
local M = {}

local default_gui_theme = "everforest"
local default_term_theme = "dracula"
local default_tmux_theme = "dracula"

local keymaps = require('keymaps.colors')

M.is_gui = (vim.fn.has('gui_running') == 1) and true or false

function M.make_themeset(term, gui, tmux)
    return {
        term_theme = term,
        gui_theme = gui,
        tmux_theme = tmux
    }
end

function M.set(themeset, preexec)

    themeset = themeset or {}
    local new_theme =  default_term_theme

    -- Initialize default or missing values
    if themeset.term == nil or themeset.term == "" then
        themeset.term = default_term_theme
    end
    if themeset.gui == nil or themeset.gui == "" then
        themeset.gui = default_gui_theme
    end
    if themeset.tmux == nil or themeset.tmux == "" then
        themeset.tmux = default_tmux_theme
    end

    if M.is_gui then
        new_theme = themeset.gui
    else
        if os.getenv("TMUX") ~= nil and
            os.getenv("TMUX") ~= "" and
            os.getenv("SSH_CONNECTION") ~= nil then
            new_theme= themeset.tmux
        else
            new_theme= themeset.term
        end
    end

    if (preexec) then
        preexec()
    end

    vim.cmd("colorscheme " .. new_theme)
    keymaps.load()
end

return M

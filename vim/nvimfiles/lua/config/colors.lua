local vim = vim
local M = {}

local default_term_theme = "dracula"
local default_tmux_theme = "dracula-soft"
local default_gui_theme_light = "dhampir"
local default_gui_theme_dark = "dracula"


local default_gui_theme = default_gui_theme_dark
if (vim.opt.background == "light") then
    default_gui_theme = default_gui_theme_light
end

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
    local neovide_theme_override = os.getenv("NEOVIDE_BG")  or nil
    if vim.fn.exists("g:neovide") then
        if neovide_theme_override ~= nil then
            vim.g.neovide_theme = neovide_theme_override;
        end
    end

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
        if (os.getenv("TMUX") ~= nil and
            os.getenv("TMUX") ~= ""  and
            os.getenv("SSH_CONNECTION") ~= nil)
        or (os.getenv("ITERM_PROFILE") == "pulldown-terminal")
        then
            new_theme= themeset.tmux
        else
            new_theme= themeset.term
        end
    end

    if (preexec) then
        preexec()
    end

    vim.cmd("colorscheme " .. new_theme)
    --if not M.is_gui then
    --    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    --    vim.cmd("hi NonText guibg=NONE ctermbg=NONE")
    --    vim.cmd("hi link EndOfBuffer NonText")
    --end
    keymaps.load()
end

return M

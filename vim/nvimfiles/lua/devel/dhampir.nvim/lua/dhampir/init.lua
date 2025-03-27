local Mlocal M = {}

M.debug = false
M.current_theme = nil
M.colors_keymapper = nil

local function debugMsg(...)
    local log_level = M.debug and vim.log.levels.INFO or vim.log.levels.DEBUG

    vim.notify(..., log_level)
end

M.original_bg_toggler = nil
local function starts_with(str, prefix)
    if (str == nil or str == "") then return false end
    return str:sub(1, #prefix) == prefix
end

function M.dracula_switch_colorscheme()
    local current_colorscheme = vim.g.colors_name or M.current_theme

    if (starts_with(current_colorscheme,"dracula")) then
        vim.cmd("colorscheme " .. "dhampir")
    elseif (starts_with(current_colorscheme, "dhampir")) then
        vim.cmd("colorscheme " .. "dracula")
    else
        M.original_bg_toggler()
    end
end

function M.dracula_option_handler()
    if (M.colors_keymapper.isBgChanging()) then
        M.colors_keymapper.setBgChanging(true)
        local current_bg = vim.o.background
        local current_colorscheme = vim.g.colors_name or M.current_theme

        if (starts_with(current_colorscheme,"dracula")) or (starts_with(current_colorscheme,"dhampir")) then
            if (current_bg == "dark") then
                vim.cmd("colorscheme " .. "dracula")
            elseif (current_bg == "light") then
                vim.cmd("colorscheme " .. "dhampir")
            end
        else
            vim.o.background = vim.o.background == "dark" and "light" or "dark"
            M.original_bg_toggler()
        end
    end
    M.colors_keymapper.setBgChanging(false)
end

local function setup_autocmds()
    local group = vim.api.nvim_create_augroup("DhampirSwitch", { clear = true })

    debugMsg("set_autocmds called")

    -- Set the OptionSet autocommand only after VIM is initialized
    vim.api.nvim_create_autocmd('OptionSet',
        {
            desc = "calls a funciton when background is toggled",
            group = augroup,
            pattern = 'background',
            callback = function()
                if (M.original_bg_toggler) then
                    M.dracula_option_handler()
                end
            end
        })

    vim.api.nvim_create_autocmd({"ColorScheme","VimEnter"},
    {
        group=augroup,
        callback = function()
                M.current_theme = vim.g.colors_name
        end
    })
end

function M.setup(color_keymapper)
    --if not color_keymapper then
    --    print("Error: dhampir requires you pass in a module with a toggle_bg method")
    --    return
    --end

    if (color_keymapper == nil) then
        debugMsg("Error: dhampir requires you pass in module with a  toggle_bg method")
        return
    end
    M.original_bg_toggler =  color_keymapper.default_bg_toggle

    color_keymapper.set_bg_toggler(require('dhampir').dracula_switch_colorscheme)
    set_autocmds()
end

return M

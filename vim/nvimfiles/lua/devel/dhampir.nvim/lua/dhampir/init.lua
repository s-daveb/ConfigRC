
local M = {}
local color_mapper = require('keymaps.colors')

M.debug = true
M.colors_keymapper = nil

local function debugMsg(...)
    if (M.debug) then
        print(...)
    end
end

M.original_bg_toggler = nil

function M.dracula_switch_colorscheme()
    if (not color_mapper.isBgChanging()) then

        local function starts_with(str, prefix)
            return str:sub(1, #prefix) == prefix
        end

        local current_colorscheme = vim.g.colors_name or "dracula"

        if  (starts_with(current_colorscheme, "dracula") or starts_with(current_colorscheme,"dhampir")) then
            color_mapper.setBgChanging(true)
            local current_bg = vim.o.background

            if (current_bg == "dark") then
                vim.cmd("colorscheme " .. "dhampir")
            else
                vim.cmd("colorscheme " .. "dracula")
            end
            color_mapper.setBgChanging(false)
        else
            debugMsg("original bg toggle")
            M.original_bg_toggler()
            color_mapper.setBgChanging(false)
        end
    end
end

local function set_autocmds()
    local augroup = vim.api.nvim_create_augroup("dhampir autocmds", {clear = true})

    print("set_autocmds called")

    -- Set the OptionSet autocommand only after VIM is initialized
    vim.api.nvim_create_autocmd('VimEnter', {
        group = augroup,
        desc = "Sets the OptionSet autocmd for `background` field",
        callback = function()
            print("Setting OptionSet autocmd")
            vim.api.nvim_create_autocmd('OptionSet',
                {
                    desc = "calls a funciton when background is toggled",
                    group = augroup,
                    pattern = 'background',
                    callback = function()
                        if (M.colors_keymapper) then
                            M.colors_keymapper.toggle_bg()
                        end
                    end
                })
        end
    })
end


function M.setup(color_keymapper)
    M.colors_keymapper = color_keymapper

    if (color_keymapper == nil) then
        print("Error: dhampir requires you pass in module with a  toggle_bg method")
        return
    end
    M.original_bg_toggler =  color_keymapper.toggle_bg

    color_keymapper.set_bg_toggler(require('dhampir').dracula_switch_colorscheme)
    set_autocmds()
end

return M

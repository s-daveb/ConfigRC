

local function dracula_switch_colorscheme()
    local function starts_with(str, prefix)
        return str:sub(1, #prefix) == prefix
    end

    local current_colorscheme = vim.g.colors_name or "nil"

    if not (starts_with(current_colorscheme, "dracula") or starts_with(current_colorscheme,"dhampir")) then
        if vim.o.background == "dark" then
            vim.o.background = "light"
        else
            vim.o.background = "dark"
        end
    else
        local current_bg = vim.o.background
        if (current_bg == "dark") then
            vim.cmd("colorscheme " .. "dhampir")
        else
            vim.cmd("colorscheme " .. "dracula")
        end
    end
end

vim.keymap.set('', '<F5>', dracula_switch_colorscheme, { noremap = true, silent = true })
vim.keymap.set('', '<leader>bg', dracula_switch_colorscheme, { noremap = true, silent = true })

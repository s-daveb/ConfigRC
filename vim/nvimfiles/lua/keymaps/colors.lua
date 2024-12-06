local vim = vim
local M = {}

function M.load()
    -- Define the function locally and use it directly in the keymap
    local function toggle_bg()
        if vim.o.background == "dark" then
            vim.o.background = "light"
        else
            vim.o.background = "dark"
        end 
    end

    vim.keymap.set('', '<F5>', toggle_bg, { noremap = true, silent = true })
    vim.keymap.set('', '<leader>bg', toggle_bg, { noremap = true, silent = true })
end

return M

-- vim: set ts=4 sw=4 et:

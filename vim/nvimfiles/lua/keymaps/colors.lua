local vim = vim
local M = {}

M.background_toggling = false

function M.isBgChanging()
    return M.background_toggling
end

function M.setBgChanging(value)
    M.background_toggling = value
    return M.background_toggling
end

function M.default_bg_toggle()
    if (M.background_toggling) then
        M.background_toggling = true
        if vim.o.background == "dark" then
            vim.o.background = "light"
        else
            vim.o.background = "dark"
        end
        M.background_toggling = false
    end
end

M.toggle_bg = M.default_bg_toggle

function M.set_bg_toggler(delegate)
	M.toggle_bg = function()
            delegate()
    end
end

function M.load()
    vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
            vim.keymap.set('n', '<leader>ss', function() vim.cmd('Inspect') end)
            vim.keymap.set({'n','i','v'}, '<F5>', function() require('keymaps.colors').toggle_bg() end, { noremap = true, silent = true })
            vim.keymap.set({'n'},'<leader>bg', function() require('keymaps.colors').toggle_bg() end, { noremap = true, silent = true })
        end
    })
end

return M

-- vim: set ts=4 sw=4 et:

local vim = vim
local M = {}

function M.default_bg_toggle()
        if vim.o.background == "dark" then
            vim.o.background = "light"
        else
            vim.o.background = "dark"
        end
end

M.toggle_bg = M.default_bg_toggle

function M.set_bg_toggler(delegate)
	M.toggle_bg = delegate
end

function M.load()
    -- Print the highlight group of the character under the cursor
    vim.keymap.set('n', '<leader>ss', function() vim.cmd('Inspect') end)
    vim.keymap.set({'n','i','v'}, '<F5>',function()  M.toggle_bg() end, { noremap = true, silent = true })
    vim.keymap.set({'n'},'<leader>bg',function()  M.toggle_bg() end, { noremap = true, silent = true })
end

return M

-- vim: set ts=4 sw=4 et:

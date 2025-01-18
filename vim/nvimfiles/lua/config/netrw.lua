local vim = vim
local M = {}

function M.open_tree()
    -- Get the current file's full path
    local filepath = vim.fn.expand('%:p')

    -- Check if the file path starts with "*://"
    local dirname = nil
    if string.match(filepath, '.*://') then
        dirname = vim.fn.expand('%:p:h')
    end

    -- Call :Lexplore and optionally edit the directory
    if dirname then
        vim.cmd("leftabove vsplit")
        vim.cmd('edit ' .. dirname)
    else
        vim.cmd('Lexplore')
    end
end

function M.load()
    -- Disable the netrw banner
    vim.g.netrw_banner = 1
    vim.g.netrw_altv = 1

    -- Netrw settings
    vim.g.netrw_preview = 1
    vim.g.netrw_liststyle = 1
    vim.g.netrw_usetab = 1

    -- Wildignore setting
    vim.opt.wildignore = {  '.DS_Store' }
end

function M.bindkeys()
    -- Check if not running in gui_vimr
    if vim.fn.exists('gui_vimr') == 0 then
        vim.g.netrw_wiw = 15
        vim.g.netrw_winsize = 20

        -- Key mappings to call M.open_tree
        vim.keymap.set('n', '<C-E>', M.open_tree, { noremap = true, silent = true })
        vim.keymap.set('n', 'gn', M.open_tree, { noremap = true, silent = true })

        -- Function to handle Netrw key bindings.
        -- These get loaded on FileType event for netrw
        local function NetrwKeyBindings()
            vim.keymap.set('n', 'gn', M.open_tree, { noremap = true, silent = true, buffer = true })
            vim.keymap.set('n', '<C-E>', ':Neotree close', { noremap = true, silent = true, buffer = true })
        end

        -- Autocommands to load custom netrw key bindings
        vim.api.nvim_create_augroup('netrw_keybindings', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'netrw',
            callback = NetrwKeyBindings,
        })
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'netrw',
            command = 'setlocal nu'
        })
    end
end

return M

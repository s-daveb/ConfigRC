local vim = vim
local M = {}

function M.load()
    -- Disable the netrw banner
    vim.g.netrw_banner = 0
    vim.g.netrw_altv = 1

    -- Netrw settings
    vim.g.netrw_preview = 1
    vim.g.netrw_liststyle = 3
    vim.g.netrw_usetab = 1

    -- Wildignore setting
    vim.opt.wildignore = { '.*', '.DS_Store' }

    -- Check if not running in gui_vimr
    if vim.fn.exists('gui_vimr') == 0 then
        vim.g.netrw_wiw = 15
        vim.g.netrw_winsize = 20

        -- Key mappings
        vim.api.nvim_set_keymap('n', '<C-E>', ':Lexplore<CR>', { noremap = true, silent = true })

        -- Function to handle Netrw key bindings
        local function NetrwKeyBindings()
            vim.api.nvim_buf_set_keymap(0, 'n', 'gn', ':Ntree<CR>', { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(0, 'n', '<C-E>', ':close<CR>', { noremap = true, silent = true })
        end

        -- Autocommands for netrw key bindings
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


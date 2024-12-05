local vim = vim
local M = {}

local neotree_cmd='Neotree position=left reveal_force_cwd=true'

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
        vim.cmd('leftabove vsplit')
        vim.cmd('e ' .. dirname)
    else
        vim.cmd(neotree_cmd)
    end
end

function M.change_root()
	local neo_tree = require("neo-tree")
    local state = neo_tree.get_state()
    local node = state.tree:get_node()

	vim.cmd("Neotree dir=" .. node.path)
end

function M.bindkeys()
    if vim.fn.exists('gui_vimr') == 0 then
    --    vim.api.nvim_set_keymap('n', '-', ':Neotree reveal reveal_force_cwd=true<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<C-e>', M.open_tree, { noremap = true, silent = true })


      -- These get loaded on FileType event for netrw
        local function NeoTreeKeyBindings()
            vim.keymap.set('n', 'gn', M.change_root, { noremap = true, silent = true, buffer = true })
            vim.keymap.set('n', '<C-E>', ':Neotree close<CR>', { noremap = true, silent = true, buffer = true })
        end

        -- Autocommands to load custom netrw key bindings
        vim.api.nvim_create_augroup('neotree_keybindings', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'neo-tree',
            callback = NeoTreeKeyBindings,
        })

    end
end

function M.load()
    M.bindkeys()
end

function M.setup()
    M.load()
end

return M

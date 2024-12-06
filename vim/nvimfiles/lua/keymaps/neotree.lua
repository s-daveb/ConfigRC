local vim = vim
local M = {}

local neotree_cmd=':Neotree position=left reveal_force_cwd=true<CR>'
local tags_cmd=':Neotree position=right document_symbols<CR>'

function M.open_tags()
    vim.cmd(tags_cmd)
end

function M.change_root()
    local neo_tree = require("neo-tree")
    local state = neo_tree.get_state()
    local node = state.tree:get_node()

    vim.cmd("Neotree dir=" .. node.path)
end

function M.bindkeys()
    -- Vimr has a built-in file browser, so these keys are disabled.
    if vim.fn.exists('gui_vimr') == 0 then
        vim.keymap.set('n', '<C-e>', neotree_cmd, { noremap = true, silent = true })
    end
    -- Define a command to open the tags tree
    vim.cmd('command! Tags ' .. tags_cmd)
    vim.keymap.set('n', '<C-t>', tags_cmd, { noremap = true, silent = true })

    -- These get loaded on FileType event for Neotree
    local function NeoTreeKeyBindings()
        vim.keymap.set('n', 'gn', M.change_root, { noremap = true, silent = true, buffer = true })
        vim.keymap.set('n', '<C-E>', ':Neotree close<CR>', { noremap = true, silent = true, buffer = true })
    end

    -- Autocommands to load custom Neotree key bindings
    vim.api.nvim_create_augroup('neotree_keybindings', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'neo-tree',
        callback = NeoTreeKeyBindings,
    })
end

function M.load()
    M.bindkeys()
end

function M.setup()
    M.load()
end

return M

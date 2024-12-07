local vim = vim
local M = {}

local nconf = require("config.neotree")

-- Function to bind keys
function M.bindkeys()
    -- Vimr has a built-in file browser, so these keys are disabled.
    if vim.fn.exists('gui_vimr') == 0 then
        vim.keymap.set('n', '<C-e>', function()
            require('neo-tree.command').execute({
                action = "focus",
                source = "filesystem",
                position = "left",
                reveal_file = vim.api.nvim_buf_get_name(0), -- Current buffer file path
                reveal_force_cwd = true,
            })
        end, { noremap = true, silent = true })
    end

    -- Define a command to open the tags tree
    vim.api.nvim_create_user_command("Tags", function()
        require('neo-tree.command').execute({
            action = "focus",
            source = "document_symbols",
            position = "right",
        })
    end, {})

    vim.keymap.set('n', '<C-t>', function()
        require('neo-tree.command').execute({
            action = "focus",
            source = "document_symbols",
            position = "right",
        })
    end, { noremap = true, silent = true })

    -- These get loaded on FileType event for Neotree
    local function NeoTreeKeyBindings()
        vim.keymap.set('n', 'gn', function()
            local state = require('neo-tree').get_state()
            local node = state.tree:get_node()
            if node and node.path then
                require('neo-tree.command').execute({
                    action = "focus",
                    source = "filesystem",
                    position = "left",
                    reveal_file = node.path,
                    reveal_force_cwd = true,
                })
            else
                vim.notify("Failed to get node path", vim.log.levels.ERROR)
            end
        end, { noremap = true, silent = true, buffer = true })

        vim.keymap.set('n', '<C-E>', function()
            require('neo-tree.command').execute({
                action = "close",
            })
        end, { noremap = true, silent = true, buffer = true })
    end

    -- Autocommands to load custom Neo-tree key bindings
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

-- vim: set ts=4 sw=4 tw=0 et ft=lua :

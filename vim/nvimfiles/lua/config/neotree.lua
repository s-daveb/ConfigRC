local vim = vim
local M = {}

local opts = {
    sources = {
        "filesystem",
        "netman.ui.neo-tree", -- netman
        "document_symbols"
    },
    filesystem = {
        hijack_netrw_behavior = 'disabled'
    },
    document_symbols = {
        window = {
            mappings = {
                ['<cr>'] = 'toggle_node',
                ['<space>'] = 'jump_to_symbol',
            }
        }
    },
    window = {
        mappings = {}
    }
}

function M.load()
    require("neo-tree").setup(opts)
    require('keymaps.neotree').load()
end

return M

local vim = vim
local M = {}

-- Try requiring neo-tree safely
local neotree_loaded, neo_tree = pcall(require, "neo-tree")
if not neotree_loaded then
	vim.notify("Neo-tree plugin is not available", vim.log.levels.ERROR)
	return
end

-- Safely require the Neo-tree command API
local command_loaded, neo_tree_command = pcall(require, "neo-tree.command")
if not command_loaded then
    vim.notify("Neo-tree command module is not available", vim.log.levels.ERROR)
    return
end

M.opts = {
	sources = {
		"filesystem",
		"netman.ui.neo-tree", -- netman
		"document_symbols"
	},
	mappings = {
	},
	filesystem = {
		hijack_netrw_behavior = 'disabled',
		window = {
			mappings = {
				['-'] = 'navigate_up',
				--['<C-E>']  = 'close_window',
				['gn'] = 'set_root'
			}
		}
	},
	document_symbols = {
		window = {
			mappings = {
				['<cr>'] = 'toggle_node',
				['<space>'] = 'jump_to_symbol',
			}
		}
	},
}


-- Function to focus Neo-tree on the left and reveal the current file
M.open_neotree_left = function()
    neo_tree_command.execute({
        action = "focus",
        source = "filesystem",
        position = "left",
        reveal_file = vim.api.nvim_buf_get_name(0), -- Current buffer file path
        reveal_force_cwd = true,
    })
end

-- Function to open document symbols on the right
M.open_tagbar_right = function()
    neo_tree_command.execute({
        action = "focus",
        source = "document_symbols",
        position = "right",
    })
end

function M.change_root()
	local state = neo_tree.get_state()
	local node = state.tree:get_node()

	vim.cmd("Neotree dir=" .. node.path)
end

-- Function to set up Neo-tree with the configured options
M.load = function()
    -- Setup Neo-tree with the options
    neo_tree.setup(M.opts)

    -- Set up the autocommand to open Neo-tree and Tagbar on file buffer enter
    vim.api.nvim_create_autocmd("VimEnter", {
        pattern = {"*.c", "*.h", "*.cpp", "*.hpp"},
        callback = function()
            M.open_neotree_left()
            M.open_tagbar_right()
        end,
        desc = "Open Neo-tree and Tagbar on buffer enter for specific file types",
    })

	require('keymaps.neotree').load()
end

return M


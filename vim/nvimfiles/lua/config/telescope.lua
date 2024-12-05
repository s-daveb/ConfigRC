local vim = vim
local M = {}

local telescope = require('telescope')
local debug = false

local function debugPrint( ... )
	if debug then
		vim.notify( ... )
	end
end

function M.load(opts)
	telescope.setup(opts)

	vim.api.nvim_create_autocmd(
		{ "BufReadPost", "BufNewFile" },
		{
			pattern = { "*" },
			callback = function()
				require('keymaps.telescope').bindkeys()
				debugPrint("Telescope keymaps bound")
			end
		})
end

return M

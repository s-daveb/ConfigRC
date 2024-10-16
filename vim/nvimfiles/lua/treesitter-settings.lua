local vim = vim
local module = {}

module.debug = false

local treesitter_options = {
		ensure_installed = { "lua", "vim", "vimdoc", "yaml", "cpp" },
		sync_install = true, -- only applies to ensure_installed providers
		auto_install = false,
    ignore_install = { "copilot.lua" },
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
		},
	}

local function debugPrint(...)
  if module.debug then
    print(...)
  end
end

function module.load_autocmds()
	debugPrint("Loading Treesitter autocmds")
	vim.api.nvim_create_autocmd({"BufNewFile","BufReadPost"}, {
  	callback = function()
    	vim.wo.foldmethod = "expr"
    	vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
    	vim.wo.foldenable = false
  	end,
	})
end

function module.load()
	require('nvim-treesitter.configs').setup(treesitter_options)
	module.load_autocmds()
	debugPrint("Treesitter settings loaded")
  vim.treesitter.language.register("copilot.lua", "markdown")
end

return module

-- vim: set ts=2 sts=2 sw=2 et ft=lua :

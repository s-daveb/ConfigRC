local module = {}

function module.load()
	project_plugin = require('project_nvim')

	-- Commented out settings means it's default, or unwanted
	project_plugin.setup({
  		--manual_mode = false,
  		detection_methods = {  "pattern" },
  		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn",  "package.json" },
  		exclude_dirs = {"~/", "~/.vim-plug/", "~/.config/nvim/", "third_party", "_deps" },
  		--ignore_lsp = {},  -- LSP clients to ignore by name eg: { "efm", ... }
  		silent_chdir = false, -- False for "Verbose"
  		scope_chdir = 'tab',  -- What scope to change the directory
  					 -- choices: global, tab,  win
  		-- For Telescope
  		--show_hidden = false, -- Show hidden files
  		--datapath = vim.fn.stdpath("data"), -- where to store "project history"
	})
end

return module

local vim = vim
local module = {}

local function load_plugin_settings()

	require('editorbehavior').load()
	require('cmp-settings').load()
	require('nvim-lsp-settings').load()

	require('local-highlight-settings').load()
	require("project-settings").load()
	require('ui-settings').load()
	require("code-companion-settings").load()
	require('telescope-settings').load()
--	require("cmp_nvim_ultisnips").setup({})

	local edgy_options
	local auto_dark_mode_options
	local xcodebuild_options
	local treesitter_options

	edgy_options = {
		bottom = {
			{
      	ft = "codecompanion",
      	title = "Code Companion Chat",
      	size = { height  = 0.45 },
      },
    }
  }
	auto_dark_mode_options = {
		set_dark_mode = function()
			vim.fn.DarkMode()  -- Defined in ~/.vim/auto-light-dark.vim
		end,
		set_light_mode =  function()
			vim.fn.LightMode() -- Defined in ~/.vim/auto-light-dark.vim
		end,
		update_interval = 10000,
	}
	xcodebuild_options = {
	}
	treesitter_options = {
		ensure_installed = { "lua", "vim", "vimdoc", "yaml", "cpp" },
		sync_install = true, -- only applies to ensure_installed providers
		auto_install = true,
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

	require('edgy').setup(edgy_options)
	require('auto-dark-mode').setup(auto_dark_mode_options)
	require("xcodebuild").setup(xcodebuild_options)
	require('nvim-treesitter.configs').setup(treesitter_options)

	vim.api.nvim_create_autocmd({"BufNewFile","BufReadPost"}, {
  	callback = function()
    	vim.wo.foldmethod = "expr"
    	vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
    	vim.wo.foldenable = false
  	end,
	})


end

local function load_custom_plugins()
	local localrc = require("localrc")
	localrc.init()

--	local ollama_complete = require('ollama-complete')
--	ollama_complete.setup(
--		{
--			keydelay=1000,
----			hostname = "vall.lan",
----			port="11434",
--			model="phi3"
--		}
--	)

end

function module.load()
	load_plugin_settings()
	load_custom_plugins()
end


return module

-- vim: set ts=2 sts=0 sw=2 noet :

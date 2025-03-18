
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv and vim.uv.fs_stat or vim.loop and vim.loop.fs_stat)(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('config.treesitter').load()
        end,
        build = ":TSUpdate"
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        ignore_install = { 'copilot.lua' },
    },
    -- Vscode-like pictograms
    {
        'onsails/lspkind.nvim',
        event = { 'VimEnter' },
    },
    -- Snippet engine
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        config = function() require('luasnip.loaders.from_snipmate').load() end
    },
    -- Auto-completion engine
    {
        'hrsh7th/nvim-cmp',
        priority = 1000,
        dependencies = {
            'lspkind.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'p00f/clangd_extensions.nvim',
            "neovim/nvim-lspconfig",
        },
        config = function()
            require('config.nvim-cmp').load()
            require('config.lsp').load()
        end,
    },
    {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
          virtual_text = false,
        })
      end,
    },
    -- GitHub Copilot
    --{
    --    'github/copilot.vim',
    --    config = function() require('config.copilot').setup() end,
    --},
    --{
    --    "CopilotC-Nvim/CopilotChat.nvim",
    --    dependencies = {
    --        { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    --        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    --    },
    --    build = "make tiktoken", -- Only on MacOS or Linux
    --    opts = {
    --        -- See Configuration section for options
    --    },
    --    -- See Commands section for default commands if you want to lazy load on them
    --},
    -- Local AI features
    -- This was not very good
    --{
    --    's-daveb/Ollama-Copilot',
    --    lazy = true,
    --    event = "VeryLazy",
    --    dependencies = { 'ollama-env' },
    --    config = function()
    --        require('config.Ollama-copilot').setup()
    --    end
    --},
    {
        'trevin-j/olly.nvim',
        lazy = true,
        event = "VeryLazy",
        dependencies = { 'ollama-env' },
        config = function()
            require('config.Ollama-copilot').setup()
        end
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "j-hui/fidget.nvim",
            "ollama-env"
        },
        config = function()
            require('config.codecompanion').setup()
        end
    },
    {
        "j-hui/fidget.nvim",
        dependencies = {
            "olimorris/codecompanion.nvim"
        },
        config = function()
            require('config.fidget'):init()
        end
    },
    -- Debugger Framework
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'mfussenegger/nvim-dap'
        },
        config = function () require('config.dap').setup() end,
    },
    -- Custom build system support
    {
    	'Shatur/neovim-tasks',
        dependencies = {
        	'nvim-lua/plenary.nvim',
		    'rcarriga/nvim-dap-ui',
        },
        config = function() require('config.neovim-tasks').setup() end,
    },
    -- Xcode project support
    {
        'wojciech-kulik/xcodebuild.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'MunifTanjim/nui.nvim',
            'mfussenegger/nvim-dap',
            'nvim-treesitter/nvim-treesitter',
            -- 'nvim-tree/nvim-tree.lua', -- (optional) to manage project files
            --'stevearc/oil.nvim', -- (optional) to manage project files
        },
        config = function()
            require('xcodebuild').setup()
        end,
    },
    --  File Navigation Plugsin
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
            },
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            local opts = {
                defaults =    {
                    file_ignore_patterns = {  ".git","Docs", "build", "%.3" },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = false,
                        override_file_sorter = false,
                        case_mode = "ignore_case",
                    },
                    file_browser = {
                        theme = "ivy",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                    }
                }
            }
            require('config.telescope').load(opts)
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('file_browser')
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            --{
            --    's-daveb/netman.nvim',
            --},
            "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config= function()
            require('config.neotree').load()
        end
    },
    ---- this project is incompatible with UNIX and only works on Linux
    --{
    --    's-daveb/netman.nvim',
    --    branch = 'custom',
    --    config = function()
    --        require('netman')
    --    end
    --},
    -- Linting Support
    {
        'mfussenegger/nvim-lint' ,
        dependencies = {
            'mhartington/formatter.nvim'
        }
    },
    -- Quality of Life editor features
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
    },
    {
        'tzachar/local-highlight.nvim',
        dependencies = {
            'folke/snacks.nvim'
        },
        config = function()
            local local_highlight = require('local-highlight')
            local_highlight.setup({
                -- file_types = {'python', 'cpp'},
                -- disable_file_types = {'tex'},
                hlgroup = 'Visual',
                cw_hlgroup = 'Underlined',
                insert_mode = true,
                min_match_len = 1,
                max_match_len = math.huge,
                highlight_single_match = true,
            })

            vim.api.nvim_create_autocmd('BufRead', {
                pattern = {'*.*'},
                callback = function(data)
                    local_highlight.attach(data.buf)
                end
            })
        end,
    },
    -- similar to tpope/surround
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        "hedyhli/outline.nvim",
        config = function()
            require('config.outline').load()
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = true,
        lazy = true,
        event = 'VeryLazy',
        --opts = { theme = 'dracula-nvim' },
    },
    -- Tmux integration
    {
        's-daveb/neomux',
        config = true
    },

}
local color_plugins = {
    'sainnhe/everforest',
	'foxbunny/vim-amber',
	'marciomazza/vim-brogrammer-theme',
    {
        'Mofiqul/dracula.nvim',
        config=true
    },
    --{
    --    "s-daveb/dhampir.nvim",
    --    lazy = false,
    --    priority = 1000
    --},
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}

local vimplugins = {
    {
        'tpope/vim-vinegar',
        config = function()
            require('config.netrw').load()
        end,
    },
    {'tpope/vim-fugitive'},
    {
      'KSP-KOS/EditorTools',
      config = function()
        -- Get the path to the EditorTools repo in the lazy directory
        local editor_tools_path = vim.fn.stdpath('data') .. '/lazy/EditorTools/VIM/vim-kerboscript'
        -- Add the path to the runtimepath
        vim.o.runtimepath = vim.o.runtimepath .. ',' .. editor_tools_path
        -- Ensure syntax is enabled for .ks files
        vim.cmd([[
          augroup filetypedetect
            autocmd! BufRead,BufNewFile *.ks set filetype=kerboscript
          augroup END
          syntax on
        ]])
      end,
    }
}

local myplugins = {
    {
        dir = "~/.config/nvim/lua/devel/project",
        name = "project",
        config = function()
            require("project").setup()
        end,
    },
    {
        dir = "~/.config/nvim/lua/devel/dhampir.nvim",
        dependencies = {
            'Mofiqul/dracula.nvim',
        },
        lazy = true,
        event = "VeryLazy",
        name = "dhampir",
        config = function()
            require('dhampir').setup(require('keymaps.colors'))
        end
    },
    {
        dir = "~/.config/nvim/lua/devel/ollama-env.nvim",
        name = "ollama-env",
        priority = 1,
        --opts = {},
        config = function()
            require("ollama-env").setup()
        end
        --[[opts = {
            host         = "localhost",
            port         = 11434,
            inline_model = "phi4:latest",
            chat_model   = "phi4:latest",
            cmd_model    = "phi4:latest",
        }
        --]]
    },
}




require('lazy').setup({
    spec =  {
        { 'LazyVim/LazyVim' },
        plugins,
        vimplugins,
        color_plugins,
		myplugins,
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = '*', -- try installing the latest L:stable version for plugins that support semver
    },
    --install = { colorscheme = { 'tokyonight', 'habamax' } },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
    }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                'gzip',
                -- 'matchit',
                -- 'matchparen',
                --'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})

-- vim: set ts=4 sw=4 sts=0 et : --

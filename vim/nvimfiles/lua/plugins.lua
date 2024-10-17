local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv and vim.uv.fs_stat or vim.loop and vim.loop.fs_stat)(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    'sainnhe/everforest',
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("config.treesitter").load()
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        ignore_install = { "copilot.lua" },
    },
    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },
    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            require("config.nvim-cmp").load()
            require("config.lsp").load()
        end,
    },
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
    },
    -- LSP manager
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            'swiftlang/sourcekit-lsp',
            'p00f/clangd_extensions.nvim',
        },
        config = function()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })

            require('mason-lspconfig').setup({
                -- A list of servers to automatically install if they're not already installed
                ensure_installed = { 'pylsp', }
            })
        end,
    },
    -- GitHub Copilot
    {
        "github/copilot.vim",
        event = "BufRead", -- Only load Copilot when entering insert mode to optimize startup time
        config = function()
            -- Optional: You can add Copilot specific configurations here
            vim.g.copilot_no_tab_map = false  -- Disable default tab mapping
            vim.api.nvim_set_keymap("i", "<C-Right>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
            vim.api.nvim_set_keymap("i", "<C-Space>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
            vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        end
    },
    -- Debugger Framework
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap"
        }
    },
    --Cmake Project support
    {
        'Civitasv/cmake-tools.nvim',
        config = function()
            require('config.cmake-tools').load()
        end
    },
    -- Xcode project support
    {
        "wojciech-kulik/xcodebuild.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
            -- "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
            --"stevearc/oil.nvim", -- (optional) to manage project files
        },
        config = function()
            require("xcodebuild").setup({})
            --require("nvim-tree").setup({}) --  So ugly!
        end,
    },
    {
        "telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
        config = function()
            require("config.telescope").load()
        end
    },
    -- Linting Support
    {
        "mfussenegger/nvim-lint",
        dependencies = {
            "mhartington/formatter.nvim"
        }
    },
    -- Quality of Life editor features
    {
        'tzachar/local-highlight.nvim',
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
    -- UI Improvements
    {
        'folke/edgy.nvim',
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
}
local vimplugins = {
    {
        'tpope/vim-vinegar',
        config = function()
            require('config.netrw').load()
        end,
    },
    {'tpope/vim-fugitive'},
}

require("lazy").setup({
    spec =  {
        { "LazyVim/LazyVim" },

        plugins,
        vimplugins
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest L:stable version for plugins that support semver
    },
    --install = { colorscheme = { "tokyonight", "habamax" } },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
    }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})


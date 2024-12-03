
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
        end
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
        config = function()
            require('luasnip.loaders.from_snipmate').load()
        end,
    },
    -- Auto-completion engine
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'lspkind.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            require('config.nvim-cmp').load()
            require('config.lsp').load()
        end,
    },
    -- LSP manager
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'swiftlang/sourcekit-lsp',
            'p00f/clangd_extensions.nvim',
        },
        config = function()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗'
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
        'github/copilot.vim',
        -- event = 'BufEnter', -- Only load Copilot when entering insert mode to optimize startup time
        config = function()
            -- Optional: You can add Copilot specific configurations here
            vim.g.copilot_no_tab_map = false  -- Disable default tab mapping
            vim.api.nvim_set_keymap('i', '<C-Right>', "copilot#Accept('<CR>')", { silent = true, expr = true })
            vim.api.nvim_set_keymap('i', '<C-Space>', "copilot#Accept('<CR>')", { silent = true, expr = true })
            vim.api.nvim_set_keymap('i', '<C-L>', "copilot#Accept('<CR>')", { silent = true, expr = true })
        end
    },
    -- Debugger Framework
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'mfussenegger/nvim-dap'
        },
        config = function()
            local port = 12345
            local dap = require('dap')
            local dapui = require('dapui')
            dap.adapters.lldb = {
                type = 'server',
                port =  port,
                executable = {
                    command = '/Users/sdavid/Downloads/codelldb-x86_64-darwin/extension/adapter/codelldb',
                    args = { '--port', port }
                }
            }
            dapui.setup()
        end,
    },
    -- Custom build system support
    {
        'Shatur/neovim-tasks',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local Path = require('plenary.path')
            require('tasks').setup({
                default_params = { -- Default module parameters with which `neovim.json` will be created.
                    cmake = {
                        cmd = 'cmake', -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
                        build_dir = tostring(Path:new('{cwd}', 'build', '{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
                        build_type = 'Debug', -- Build type, can be changed using `:Task set_module_param cmake build_type`.
                        dap_name = 'lldb',
                        args = { -- Task default arguments.
                            configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', 'Ninja', '-D', 'USE_MOLD=1', '-D', 'USE_CCACHE=1' },
                        },
                    },
                },
                save_before_run = true, -- If true, all files will be saved before executing a task.
                params_file = 'neovim.json', -- JSON file to store module and task parameters.
                quickfix = {
                    pos = '', -- Default quickfix position.
                    height = 12, -- Default height.
                },
                dap_open_command = require('dapui').open,
            })
            --require('devel.project').setup({})
        end,
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
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            }
        },
        config = function()
            require('config.telescope').load()
            require('telescope').load_extension('fzf')
        end
    },
    -- Linting Support
    {
        'mfussenegger/nvim-lint' ,
        dependencies = {
            'mhartington/formatter.nvim'
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
    {
        'hedyhli/outline.nvim',
        lazy = true,
        cmd = { 'Outline', 'OutlineOpen' },
        keys = { -- Example mapping to toggle outline
            { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
        },
        opts = {
            -- Your setup opts here
        },
        config = function() require('outline').setup({}) end,
    },
}
local color_plugins = {
    'sainnhe/everforest',
    'Mofiqul/dracula.nvim'
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

require('lazy').setup({
    spec =  {
        { 'LazyVim/LazyVim' },
        plugins,
        vimplugins,
        color_plugins
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
                -- 'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})


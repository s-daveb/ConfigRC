local vim = vim
local M  = {}

local is_gui = (vim.fn.has('gui_running') == 1) and true or false
local colorconfig = require('config.colors')

local _border = "rounded"

local neovide_window_base_opacity = 0.75
local default_neovide_transparency = 0.75

-- Create an autogroup named 'NeovideSettings'
local neovide_group = vim.api.nvim_create_augroup('NeovideSettings', { clear = true })

function M.set_neovide_opacity(amount)
    if vim.g.neovide then
        vim.g.neovide_opacity = neovide_window_base_opacity
        vim.g.neovide_normal_opacity = amount
        vim.g.neovide_show_borders = true
        vim.g.neovide_window_blurred = true
    end
end

function M.setup_gui(opts)
    vim.opt.guifont = "Berkeley_Mono:h14"

    if vim.g.neovide then
        M.configure_transparency(opts.transparency);
    end

end

function M.configure_transparency(amount)
    if vim.g.neovide then
        vim.g.neovide_theme = 'auto'
        vim.g.neovide_opacity = 1.0

        -- Create an autocommand in the 'NeovideSettings' group
        M.set_neovide_opacity(amount)

        -- Define a new Neovim command :NeovideTrans
        vim.api.nvim_create_user_command('SetOpacity', function()
            -- Prompt for the value
            local input = vim.fn.input("Enter the amount: ")
            -- Check if the input is a valid number
            if tonumber(input) then
                -- Call M.neovide_trans with the entered value
                M.set_neovide_opacity(tonumber(input))
            else
                print("Invalid input. Please enter a numeric amount.")
            end
        end, { desc = 'Call neovide_trans with a specified amount' })
    end
end

function M.load(opts)
    opts = opts or {}
    opts.transparency = opts.transparency or default_neovide_transparency

    if not is_gui then
        vim.g.everforest_transparent_background = 1 -- disable(??) everforest background
    end

    -- Create an autocommand in the 'NeovideSettings' group
    vim.api.nvim_create_autocmd({'UIEnter'}, {
        group = neovide_group,
        callback =  function()
            M.setup_gui(opts)
        end
    })
    vim.o.winborder = 'rounded'

    colorconfig.set_theme_pack(nil, nil)
end

return M

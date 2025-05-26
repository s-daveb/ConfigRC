local vim = vim
local M  = {}

local is_gui = (vim.fn.has('gui_running') == 1) and true or false
local colorconfig = require('config.colors')


local neovide_window_base_opacity = 0.75
local default_neovide_transparency = 0.50

-- Create an autogroup named 'NeovideSettings'
local neovide_group = vim.api.nvim_create_augroup('NeovideSettings', { clear = true })


function M.neovide_trans(amount)
    if vim.g.neovide then
        vim.g.neovide_opacity = neovide_window_base_opacity
        vim.g.neovide_normal_opacity = amount
        vim.g.neovide_show_borders = true
        vim.g.neovide_window_blurred = true
    end
end

function M.load(opts)
    opts = opts or {}
    opts.transparency = opts.transparency or default_neovide_transparency

    if is_gui then
        vim.g.neovide_theme = 'auto'
        vim.g.neovide_opacity = 1.0

        vim.opt.guifont = "Berkeley_Mono:h16"

        -- Create an autocommand in the 'NeovideSettings' group
        vim.api.nvim_create_autocmd('User', {
            pattern = "VeryLazy",
            group = neovide_group,
            callback =  function() M.neovide_trans(opts.transparency) end
        })

        -- Define a new Neovim command :NeovideTrans
        vim.api.nvim_create_user_command('SetOpacity', function()
            -- Prompt for the value
            local amount = vim.fn.input("Enter the amount: ")
            -- Check if the input is a valid number
            if tonumber(amount) then
                -- Call M.neovide_trans with the entered value
                M.neovide_trans(tonumber(amount))
            else
                print("Invalid input. Please enter a numeric amount.")
            end
        end, { desc = 'Call neovide_trans with a specified amount' })
    else
        vim.g.everforest_transparent_background = 1
    end

    colorconfig.set_theme_pack(nil, nil)
end

return M

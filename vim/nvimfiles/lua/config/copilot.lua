local M = {}

function M.setup()
    vim.g.copilot_no_tab_map = false  -- Disable default tab mapping

    local function bind_copilot()
        vim.api.nvim_set_keymap('i', '<C-Right>', "copilot#Accept('<CR>')", { silent = true, expr = true })
        vim.api.nvim_set_keymap('i', '<C-Space>', "copilot#Accept('<CR>')", { silent = true, expr = true })
        vim.api.nvim_set_keymap('i', '<C-L>', "copilot#Accept('<CR>')", { silent = true, expr = true })
    end

    vim.api.nvim_create_autocmd('VimEnter', {
        callback = bind_copilot,
        group = vim.api.nvim_create_augroup('CopilotBindings', { clear = true }),
        desc = "Bind Copilot keys on VimEnter",
    })
end

return M


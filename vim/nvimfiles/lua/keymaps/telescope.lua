local M = {}

function M.bindkeys()
    local opts = { noremap = true, silent = true, buffer = true }

    vim.keymap.set('n', '<C-P>', require('telescope.builtin').find_files, opts)
    vim.keymap.set('n', '<leader>find', require('telescope.builtin').fd, opts)
    vim.keymap.set('n', '<leader>buff', require('telescope.builtin').buffers, opts)
    vim.keymap.set('n', '<leader>rf', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', '<leader>reff', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', '<leader>icalls', require('telescope.builtin').lsp_incoming_calls, opts)
    vim.keymap.set('n', '<leader>ocalls', require('telescope.builtin').lsp_outgoing_calls, opts)
    vim.keymap.set('n', '<leader>ocalls', require('telescope.builtin').lsp_outgoing_calls, opts)

    vim.keymap.set('n', '<leader>def', require('telescope.builtin').lsp_definitions, opts)
    vim.keymap.set('n', '<leader>]', require('telescope.builtin').lsp_definitions, opts)

    vim.keymap.set('n', '<leader>def', require('telescope.builtin').lsp_definitions, opts)
    vim.keymap.set('n', '<leader>]', require('telescope.builtin').lsp_definitions, opts)
end

return M

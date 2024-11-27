local M = {}


function M.bindkeys()
    local tl_builtin = require('telescope.builtin')
    local opts = { noremap = true, silent = true, buffer = true }

    vim.keymap.set('n', '<C-P>', tl_builtin.find_files, opts)
    vim.keymap.set('n', '<leader>files', ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)
    vim.keymap.set('n', '<leader>find', tl_builtin.fd, opts)
    vim.keymap.set('n', '<leader>buff', tl_builtin.buffers, opts)
    vim.keymap.set('n', '<leader>rf', tl_builtin.lsp_references, opts)
    vim.keymap.set('n', '<leader>reff', tl_builtin.lsp_references, opts)
    vim.keymap.set('n', '<leader>icalls', tl_builtin.lsp_incoming_calls, opts)
    vim.keymap.set('n', '<leader>ocalls', tl_builtin.lsp_outgoing_calls, opts)
    vim.keymap.set('n', '<leader>ocalls', tl_builtin.lsp_outgoing_calls, opts)

    vim.keymap.set('n', '<leader>def', tl_builtin.lsp_definitions, opts)
    vim.keymap.set('n', '<leader>]', tl_builtin.lsp_definitions, opts)

    vim.keymap.set('n', '<leader>def', tl_builtin.lsp_definitions, opts)
    vim.keymap.set('n', '<leader>]', tl_builtin.lsp_definitions, opts)
end

return M

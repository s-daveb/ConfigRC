local vim = vim
local telescope = require('telescope')
local tele_builtin = require('telescope.builtin')
local module = {}

local telescope_options = {
  extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
  }
}
local function bindkeys()
  local opts = { noremap = true, silent = true, buffer = true }

  vim.keymap.set('n', '<C-P>',    tele_builtin.find_files, opts)
  vim.keymap.set('n', '<leader>find', tele_builtin.fd, opts)
  vim.keymap.set('n', '<leader>buff', tele_builtin.buffers, opts)
  vim.keymap.set('n', '<leader>rf', tele_builtin.lsp_references, opts)
  vim.keymap.set('n', '<leader>reff', tele_builtin.lsp_references, opts)
  vim.keymap.set('n', '<leader>icalls', tele_builtin.lsp_incoming_calls, opts)
  vim.keymap.set('n', '<leader>ocalls', tele_builtin.lsp_outgoing_calls, opts)
  vim.keymap.set('n', '<leader>ocalls', tele_builtin.lsp_outgoing_calls, opts)

  vim.keymap.set('n', '<leader>def', tele_builtin.lsp_definitions, opts)
  vim.keymap.set('n', '<leader>]', tele_builtin.lsp_definitions, opts)

  vim.keymap.set('n', '<leader>def', tele_builtin.lsp_definitions, opts)
  vim.keymap.set('n', '<leader>]', tele_builtin.lsp_definitions, opts)
end

function module.load()
		telescope.setup(telescope_options)
		telescope.load_extension('fzf')

  vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
      pattern = { "*" },
      callback = bindkeys
  })
end

return module

-- vim: set ts=2 sw=2 sts=2 et:

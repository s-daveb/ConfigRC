local vim = vim
local telescope = require('telescope')
local module = {}

module.debug = false

local function debugPrint( ... )
  if module.debug then
    print( ... )
  end
end

local telescope_options = {
  defaults =  {
    file_ignore_patterns = {  ".git", "Docs/.*", "%.3" },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = false,
      case_mode = "ignore_case",
    }
  }
}
local function bindkeys()
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
  debugPrint("Telescope keybindings set")
end

function module.load()
  telescope.setup(telescope_options)
  telescope.load_extension('fzf')

  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = { "*" },
    callback = function()
      --local exclusions = { "netrw", "vista","codecompanion" }
      --if (not vim.tbl_contains(exclusions, vim.bo.filetype)) then
      bindkeys()
      --end
    end
  })
end

return module

-- vim: set ts=2 sw=2 sts=2 et:

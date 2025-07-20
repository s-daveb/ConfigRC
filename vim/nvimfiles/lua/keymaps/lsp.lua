local vim = vim
local module = {}

function module.set_keys(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }

  local quickfix_args = { context = { only = { "quickfix" } }, apply = true }

  -- Mappings
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>q]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>stop', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --
  buf_set_keymap('n', '<leader>[', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  buf_set_keymap('n', '<leader>h', '<cmd>lua require(\'config.lsp\').hover_diagnostic()<CR>', opts)


  buf_set_keymap('n', '<leader>kf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)


  local quickfix = function ()
      vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end, apply = true
      })
  end

  vim.keymap.set('n', '<leader>fix', quickfix, opts)

  -- clangd specific
  buf_set_keymap('n', '<leader>hint', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>' , opts)
  buf_set_keymap('n', '<leader>gh', '<cmd>ClangdSwitchSourceHeader<CR>', opts)

end

return module

-- vim: set ts=2 sw=2 sts=2 et:

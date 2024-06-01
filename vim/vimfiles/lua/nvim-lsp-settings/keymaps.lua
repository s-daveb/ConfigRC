local vim = vim
local module = {}

function module.set_keys(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap=true, silent=true }
	local quickfix_opts = opts
	quickfix_opts.callback =  function()
    vim.lsp.buf.code_action({ context = { only = {"quickfix"} }, apply=true })
  end

  -- Mappings
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>q]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>stop', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', opts)
  buf_set_keymap('n', '<leader>rename', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>]', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

  buf_set_keymap('n', '<leader>[', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>hint', '<cmd>ClangdToggleInlayHints<CR>', opts)

  buf_set_keymap('n', '<leader>ref', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

	buf_set_keymap('n', '<leader>gh', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
	buf_set_keymap('n', '<leader>kf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)


  buf_set_keymap('n', '<leader>fix', '', quickfix_opts)
end

return module

-- vim: set ts=2 sw=2 sts=2 et:


-- Highlight whitespace
vim.cmd([[highlight ExtraWhitespace ctermbg=red guibg=red]])
vim.cmd([[match ExtraWhitespace /\s\+$/]])

-- Optional: Automatically remove trailing whitespace on save
vim.api.nvim_exec([[
  autocmd BufWritePre * %s/\s\+$//e
]], false)

-- Define a function to remove trailing whitespace
function RemoveTrailingWhitespace()
  -- Search and replace trailing whitespace globally in the buffer
  vim.api.nvim_command([[%s/\s\+$//e]])
end

vim.cmd([[command! TrimWhiteSpace lua RemoveTrailingWhitespace()]])

-- Map CTRL-W F to the function in normal mode
vim.api.nvim_set_keymap('n', '<leader>ws', ':TrimWhiteSpace<CR>', { noremap = true, silent = true })


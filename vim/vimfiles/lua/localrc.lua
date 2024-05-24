-- ~/.config/nvim/lua/localrc.lua
local M = {}
local lsp_util = require('lspconfig.util')

M.debug = true 

function M.debugPrint(message)
	if M.debug then
		print(message)
	end
end

function M.setup_keymap()
  -- Map '*' in normal mode to call cd_to_root without parameters
  vim.api.nvim_set_keymap('n', '_', '<cmd>lua require("localrc").cd_to_root()<CR>', { noremap = true, silent = true })
end

function M.setup_autocmd()
  -- Automatically adjust the root directory when opening a file
  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
			if vim.fn.exists("g:gui_vimr") == 1 then
      	vim.defer_fn(M.cd_to_root, 500)
    	else
				M.cd_to_root()
    	end
    end,
  })
end

function M.cd_to_root(dirpath)
  dirpath = dirpath or vim.fn.expand('%:p:h')
  local root_path = lsp_util.find_git_ancestor(dirpath) or dirpath

	M.debugPrint("Changing dir to " .. root_path)
  if (root_path and root_path ~= "") then
  	vim.cmd('lcd ' .. root_path)

  	M.load_localrc(root_path)
	end
end

function M.load_localrc(root_path)
  local localrc_path = root_path .. '/.vim/local.vimrc'
  if vim.fn.filereadable(localrc_path) == 1 then
    vim.cmd('source ' .. localrc_path)
  end
end

function M.init()
  -- Setup command to change to project root
  vim.api.nvim_create_user_command('ToProjectRoot', function() M.cd_to_root() end, {})
  M.setup_keymap()
  M.setup_autocmd()
end

return M

-- vim: set ts=2 sw=2 sts=2 noet:

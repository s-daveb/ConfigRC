local vim = vim
local M  = {}


function M.load()
	require('config.lsp.providers').init()

	vim.diagnostic.config({
  		virtual_text = {
    			-- source = "always",  -- Or "if_many"
    			prefix = '🞊 :', -- Could be '■', '▎', 'x'
  		},
  		severity_sort = true,
  		float = {
    			source = "always",  -- Or "if_many"
  		},
	})


end

return M

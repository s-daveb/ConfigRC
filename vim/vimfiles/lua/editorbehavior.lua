local vim =  vim
local os_name = vim.loop.os_uname().sysname
local module = {}

function module.load()
	-- Initialize some keymaps to make tab switching easier.
	if (vim.fn.has('gui_running') ==1) and (1 ~= vim.fn.has('macvim')) then
		require('gui').setup()
	end

	if (os_name == "Darwin") then
		require('mac_keybindings').setup()
	end

  -- Set pre-write buffer autocmd to clang-format the document before saving
  vim.api.nvim_create_autocmd("BufWritePre", {
    	pattern = {"*.c", "*.cpp", "*.h", "*.hpp"},
    	callback = function()
      		vim.lsp.buf.format({ async = false })
    	end
  })
end


return module;

-- vim: set ts=2 sts=0 sw=2 noet :

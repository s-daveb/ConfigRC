
local module = {}

function module.load()
	-- Detect VimR gui, and set some keyamppings (emulate MacVim, etc)
	if vim.fn.exists('g:nvim_vimr') then
		require('vimr').keymaps.init()
	end
end


return module;

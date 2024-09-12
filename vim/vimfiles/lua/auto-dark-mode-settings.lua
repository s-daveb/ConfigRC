local vim = vim
local module = {}

module.debug = false

local auto_dark_mode_options = {
		set_dark_mode = function()
			vim.fn.DarkMode()  -- Defined in ~/.vim/auto-light-dark.vim
		end,
		set_light_mode =  function()
			vim.fn.LightMode() -- Defined in ~/.vim/auto-light-dark.vim
		end,
		update_interval = 10000,
	}


local function debugPrint(...)
  if module.debug then
    print(...)
  end
end

function module.load()

	require('auto-dark-mode').setup(auto_dark_mode_options)

	debugPrint("Auto-dark-mode settings loaded")
end

return module

-- vim: set ts=2 sts=2 sw=2 et ft=lua :

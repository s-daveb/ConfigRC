local vim = vim
local module = {}

module.debug = false

local edgy_options = {
		bottom = {
			{
      	ft = "codecompanion",
      	title = "Code Companion Chat",
      	size = { height  = 0.45 },
      },
      {
      	ft = "vimcmake",
      	title = "cmake-tools.nvim",
      	size = { height  = 0.25 },
      },
      {
      	ft = "qf",
      	title = "quickfix",
      	size = { height  = 0.25 },
      },
    }
  }

local function debugPrint(...)
  if module.debug then
    print(...)
  end
end

function module.load()
	require('edgy').setup(edgy_options)
	debugPrint("Edgy settings loaded")
end

return module

-- vim: set ts=2 sts=2 sw=2 et ft=lua :

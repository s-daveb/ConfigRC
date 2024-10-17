local vim = vim
local module = {}

local cmake_tools = require('cmake-tools')

local cmake_settings = require('config.cmake-tools.settings')
local keybindings = require('keymaps.cmake')

function module.load()
	cmake_tools.setup(cmake_settings)
  keybindings.setup()
end

return module



-- vim: set ts=2 sts=2 sw=2 expandtab ft=lua :

local vim = vim
local this = {}

local default_color = 'everforest'

function this.initialize(colorscheme)
	if colorscheme == nil or colorscheme == "" then
		colorscheme = default_color
	end
	local success = pcall(vim.cmd, "colorscheme " .. colorscheme)

	if success then
		vim.notify('colorscheme ' .. colorscheme .. ' loaded!')
	else
		vim.notify('colorscheme ' .. colorscheme .. ' not installed!')
	end
end


return this

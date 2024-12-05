local vim = vim
local M = {}

function M.load(opts)
    require("neo-tree").setup(opts)
    require('keymaps.neotree').load()
end

return M

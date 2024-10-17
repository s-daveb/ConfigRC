local vim = vim
local M = {}

local telescope = require('telescope')
local keymaps = require('keymaps.telescope')

local debug = false

local function debugPrint( ... )
    if debug then
        vim.notify( ... )
    end
end

local telescope_options = {
    defaults =    {
        file_ignore_patterns = {  ".git", "Docs/.*", "%.3" },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = false,
            case_mode = "ignore_case",
        }
    }
}

function M.load(opts)
    local opts = opts or {}

    telescope.setup(telescope_options)
    telescope.load_extension('fzf')

    vim.api.nvim_create_autocmd(
        { "BufReadPost", "BufNewFile" },
        {
            pattern = { "*" },
            callback = function()
                keymaps.bindkeys()
                debugPrint("Telescope keymaps bound")
            end
        })

end

return M

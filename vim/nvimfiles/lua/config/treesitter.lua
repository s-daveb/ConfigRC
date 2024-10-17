local vim = vim
local M = {}
local debug = false

local function debugPrint(...)
  if debug then
    print(...)
  end
end

function M.load()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { "lua", "vim", "vimdoc", "yaml", "cpp" },
    sync_install = true, -- only applies to ensure_installed providers
    auto_install = false,
    ignore_install = { "copilot.lua" },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  })

  vim.api.nvim_create_autocmd({"BufNewFile","BufReadPost"}, {
    callback = function()
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
      vim.wo.foldenable = false
    end,
  })

  vim.treesitter.language.register("copilot.lua", "markdown")

  debugPrint("Treesitter settings loaded")
end

return M


-- vim: set ts=2 sts=2 sw=2 et ft=lua :

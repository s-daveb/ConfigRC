local M = {}
local debug =  false

local function debugPrint(...)
  if debug then
    print(...)
  end
end

function M.load()
  local luajit_version = tonumber(jit.version:match("2%.%d+%.(%d+)$"))
  local highlight_enabled = false

  debugPrint("Luajit version is " .. luajit_version )
  -- Treesitter highlighting is broken with old versions of luajit
  if luajit_version and luajit_version > 1732813678 then
    debugPrint("Luajit version " .. luajit_version .. " can run Treesitter")
    highlight_enabled = true
  end

  require('nvim-treesitter.configs').setup({
    ensure_installed = { "lua", "vim", "vimdoc", "yaml", "cpp" },
    sync_install = true, -- only applies to ensure_installed providers
    auto_install = true,
    ignore_install = { "copilot.lua" },
    highlight = {
      enable = highlight_enabled
    },
    indent = {
      enable = true,
    },
  })

  vim.api.nvim_create_autocmd({"BufNewFile","BufReadPost"}, {
    callback = function()
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
      vim.wo.foldenable = false
    end,
  })

  --vim.treesitter.language.register("copilot.lua", "markdown")

  debugPrint("Treesitter settings loaded")
end

return M


-- vim: set ts=2 sts=2 sw=2 et ft=lua :

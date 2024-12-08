local M = {}
local debug =  false

local function debugPrint(...)
  if debug then
    print(...)
  end
end

-- Luajit versions that have issues with TS highlight
local highlight_luajit_blocklist = {
  "LuaJIT 2.1.1732813678"
}

function M.load()
  local luajit_version = jit.version
  local highlight_enabled = true

  debugPrint("Lujit version is " .. luajit_version )
  for _, v in ipairs(highlight_luajit_blocklist) do
    if luajit_version == v then
      debugPrint("Disabling TS highlight: Luajit version " .. luajit_version .. " is in the blocklist")
      highlight_enabled = false
    end
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
end

return M


-- vim: set ts=2 sts=2 sw=2 et ft=lua :

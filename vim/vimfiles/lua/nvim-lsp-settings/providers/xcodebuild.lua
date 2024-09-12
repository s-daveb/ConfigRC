local vim = vim
local module = {}

local xcodebuild = require('xcodebuild')
local xcb_dap = require("xcodebuild.integrations.dap")

local xcodebuild_options = {}

local codelldbPath =
  os.getenv("HOME") ..
    "/Users/sdavid/" ..
    "Downloads/codelldb-aarch64-darwin/extension/adapter/codelldb"

local group = vim.api.nvim_create_augroup('xcodebuild-dap', { clear = true })

function module.setup(opts)
  xcodebuild.setup(xcodebuild_options)
  xcb_dap.setup(codelldbPath)

  vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
    group = group,
    pattern = '*.swift',
    callback = function()
      vim.keymap.set("n", "<leader>dd", xcb_dap.build_and_debug, { desc = "Build & Debug" })
      vim.keymap.set("n", "<leader>dr", xcb_dap.debug_without_build, { desc = "Debug Without Building" })
      vim.keymap.set("n", "<leader>dt", xcb_dap.debug_tests, { desc = "Debug Tests" })
      vim.keymap.set("n", "<leader>dT", xcb_dap.debug_class_tests, { desc = "Debug Class Tests" })
      vim.keymap.set("n", "<leader>b", xcb_dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", xcb_dap.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
      vim.keymap.set("n", "<leader>dx", xcb_dap.terminate_session, { desc = "Terminate Debugger" })
    end,
  })
end

return module

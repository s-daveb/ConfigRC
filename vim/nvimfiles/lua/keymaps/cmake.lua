local vim = vim
local module = {}

local function find_cmake_file()
  local current_dir = vim.fn.getcwd()
  while current_dir do
    if vim.fn.glob(current_dir .. '/CMakeLists.txt') ~= '' then
      return true
    end
    local parent_dir = vim.fn.fnamemodify(current_dir, ':h')
    if parent_dir == current_dir then
      break
    end
    current_dir = parent_dir
  end
  return false
end

local function set_cmake_keymap()
  if find_cmake_file() then
    vim.api.nvim_set_keymap('n', '<leader>btest', ':CMakeBuild ctest<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>build', ':lua require("cmake-tools-config.keybindings").run_cmake_with_target()<CR>', { noremap = true, silent = true })
  else
    if vim.fn.maparg('<leader>btest', 'n') ~= '' then
      vim.api.nvim_del_keymap('n', '<leader>btest')
    end
    if vim.fn.maparg('<leader>build', 'n') ~= '' then
      vim.api.nvim_del_keymap('n', '<leader>build')
    end
  end
end

function module.run_cmake_with_target()
  local target = vim.fn.input("Enter CMake target: ")
  if target == "" then
		target = "all"
	end

  local cmd = ":CMakeBuild " .. target
  vim.api.nvim_command(cmd)
end

function module.setup()
  vim.api.nvim_create_autocmd({"DirChanged", "VimEnter"}, {
    callback = function()
      set_cmake_keymap()
    end
  })
end

return module

-- vim: set ts=2 sts=2 sw=2 et ft=lua :

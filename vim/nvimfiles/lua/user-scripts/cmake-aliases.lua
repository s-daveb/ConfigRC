local vim = vim
local subcommands = require('tasks.subcommands')

-- Define custom commands for CMake tasks using a data-driven approach
local commands = {
  {
    cmd_name = 'CMakeSet',
    task_cmd = 'Task set_module_param cmake',
    nargs = '*',
    complete = true
  },
  {
    cmd_name = 'CMakeConfigure',
    task_cmd = 'Task start cmake configure',
    nargs = 0
  },
  {
    cmd_name = 'CMakeBuild',
    task_cmd = 'Task start cmake build',
    nargs = 0
  },
  {
    cmd_name = 'CMakeRun',
    task_cmd = 'Task start cmake run',
    nargs = 0
  },
  {
    cmd_name = 'CMakeDebug',
    task_cmd = 'Task start cmake debug',
    nargs = 0
  },
}

for _, cmd in ipairs(commands) do
  local opts = { nargs = cmd.nargs }

  if cmd.complete then
    opts.complete = function(arg, line)
      -- Assuming subcommands.complete is defined elsewhere
      return subcommands.complete(arg, cmd.task_cmd .. ' ')
    end
  end

  vim.api.nvim_create_user_command(
    cmd.cmd_name,
    function(args)
      if cmd.task_cmd ~= nil then
        if cmd.nargs == 0 then
          vim.cmd(cmd.task_cmd)
        else
          vim.cmd(cmd.task_cmd .. ' ' .. args.args)
        end
      end
      if (cmd.postexec) then
        cmd.postexec()
      end
    end,
    opts
  )
end
-- vim: ts=2 sw=2 et :

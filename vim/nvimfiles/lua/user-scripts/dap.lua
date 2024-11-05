local vim = vim
local subcommands = require('tasks.subcommands')

-- Define custom commands for CMake tasks using a data-driven approach
local commands = {
  {
    cmd_name = 'DebugStop',
    task_cmd = 'Task cancel',
    nargs = 0,
    postexec = function()
      require('dapui').close()
    end
  },
  {
    cmd_name = "Break",
    task_cmd = nil,
    nargs = 0,
    postexec = require('dap').toggle_breakpoint
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

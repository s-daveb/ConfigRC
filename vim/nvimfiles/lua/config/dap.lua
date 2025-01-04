local vim = vim
local dap = require('dap')
local dapui = require('dapui')
local subcommands = require('tasks.subcommands')

local M = {}

-- Define custom commands for CMake tasks using a data-driven approach
local function setup_commands()
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
end

function M.setup()
    local port = 12345
    local codelldb_path = '/Users/sdavid/Downloads/codelldb-arm64-darwin/adapter/codelldb'

    -- if the arch is x86_64, use codelldb-x86_64-darwin
    -- if the arch is arm64, use codelldb-arm64-darwin
    local arch = vim.fn.system('uname -m')
    if arch == 'x86_64\n' then
        codelldb_path = '/Users/sdavid/Downloads/codelldb-x86_64-darwin/extension/adapter/codelldb'
    else
        codelldb_path = '/Users/sdavid/Downloads/codelldb-arm64-darwin/adapter/codelldb'
    end

    dap.adapters.lldb = {
        type = 'server',
        port =  port,
        executable = {
            command = codelldb_path,
            args = { '--port', port }
        }
    }
    dapui.setup()

    setup_commands()
end

return M

-- vim: ts=4 sw=4 et sts=4 :

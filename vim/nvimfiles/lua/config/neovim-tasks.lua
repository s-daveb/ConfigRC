local vim = vim
local tasks = require('tasks')
local subcommands = require('tasks.subcommands')
local dapui = require('dapui')


local M = {}

local function setup_commands()
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
            nargs = '*',  -- Allow the command to accept variable number of arguments
            ---@diagnostic disable-next-line: unused-local
            complete = function(arg_lead, cmd_line, cursor_pos)
                -- Provide completion suggestions for CMake configure arguments if needed
                -- This function can be customized based on your requirements
                return { '-D', '-G', '-W', '--warn-uninitialized', '--warn-unused-vars' }
            end
        },
        {
            cmd_name = 'CMakeBuild',
            task_cmd = 'Task start cmake build',
            nargs = '*' -- Allow the command to accept variable number of arguments

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
        {
            cmd_name = 'CMakeClean',
            task_cmd = 'Task start cmake clean',
            nargs = 0
        }
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

    vim.api.nvim_create_user_command('CMakePump', function(args)
        local ProjectConfig = require('tasks.project_config')
        local project_config = ProjectConfig.new()
        local orig_cmd = project_config.cmake.cmd
        -- Prefix pump before the original cmake command
        project_config.cmake.cmd = 'pump ' .. orig_cmd
        tasks.start('cmake', 'build', args.args)
        -- Restore the original command
        project_config.cmake.cmd = orig_cmd
        project_config:write()
    end, { nargs = '*' })

end

function M.setup()
    local Path = require('plenary.path')
    local cpu_arch = vim.loop.os_uname().machine
    tasks.setup({
        default_params = { -- Default module parameters with which `neovim.json` will be created.
            cmake = {
                cmd = 'cmake', -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
                build_dir = tostring(Path:new('{cwd}', 'build', '{build_type}.' .. cpu_arch  )), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
                build_type = 'Debug', -- Build type, can be changed using `:Task set_module_param cmake build_type`.
                dap_name = 'lldb',
                args = { -- Task default arguments.
                    configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', 'Ninja' },
                },
            },
        },
        save_before_run = true, -- If true, all files will be saved before executing a task.
        params_file = 'neovim.json', -- JSON file to store module and task parameters.
        quickfix = {
            pos = 'botright', -- Default quickfix position.
            height = 12, -- Default height.
        },
        dap_open_command = dapui.open,
    })


    setup_commands()
end
return M

-- vim: ts=4 sw=4 sts=4 et :

local vim = vim

-- Define a function to remove trailing whitespace
function RemoveTrailingWhitespace()
  -- Search and replace trailing whitespace globally in the buffer
  vim.api.nvim_command([[%s/\s\+$//e]])
end

-- Define a command to call the function
vim.cmd([[command! TrimWhiteSpace lua RemoveTrailingWhitespace()]])

-- Automatically remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = RemoveTrailingWhitespace
})

-- Syntax Highlighting debugging function
function SynStack()
    if vim.fn.exists("*synstack") == 0 then
        return
    end
    local stack = vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))
    local names = vim.fn.map(stack, 'synIDattr(v:val, "name")')
    print(vim.inspect(names))
end


function SplitHelp(topic)
    if topic == nil or topic == "" then
        print("Please provide a help topic")
        return
    end
    vim.cmd("split | help " .. topic)
end


function SplitHelp(opts)
    -- Check if any argument was provided
    if not opts.args or opts.args == "" then
        print("Please provide a help topic")
        return
    end

    -- Get the current window width
    local win_width = vim.api.nvim_win_get_width(0)

    -- Use the provided argument(s) directly
    local args = opts.args

    -- Decide split direction based on width and execute the help command
    if (win_width / 2) > 45 then
        vim.cmd("vertical belowright help " .. args)
    else
        vim.cmd("help " .. args)
    end
end

-- Create a user command "H" that uses the SplitHelp function
vim.api.nvim_create_user_command("H", SplitHelp, { nargs = '*', complete = "help" })

vim.api.nvim_create_user_command("ReloadModule", function(args)
    local module = args.args
    if module == "" then
        print("Please provide a module name to reload.")
        return
    end

    local plenary_reload = require("plenary.reload").reload_module
    plenary_reload(module)
    print("Reloaded module: " .. module)
end, { nargs = 1, complete = "file" })

vim.api.nvim_create_user_command("ReLazy", function()
    -- Reload the plugin.lua file
    local plugin_file = vim.fn.stdpath("config") .. "/lua/plugins.lua"

    -- Reinitialize lazy.nvim
    --require("lazy").setup() -- Ensure `lazy.nvim` is properly reconfigured
    dofile(plugin_file)


    print("Reloaded plugin.lua and reinitialized lazy.nvim")
end, {})

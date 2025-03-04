local M = {}

M.debug = false

local debugPrint = function(message)
    if (M.debug) then
        print(message)
    end

end


local function find_project_dir(start_dir)
    debugPrint("searching for project_dir")
    -- Collect all parent directories from root (/) to the given path
    local dirs = {}
    local dir = start_dir

    while dir and dir ~= '/' do
        table.insert(dirs, 1, dir)  -- Insert at the beginning to process from root downwards
        dir = vim.fn.fnamemodify(dir, ':h')
    end

    -- Ensure the root `/` is included
    table.insert(dirs, 1, '/')

    -- Iterate from the root down to start_dir
    for _, path in ipairs(dirs) do
        if vim.fn.isdirectory(path .. '/.git') == 1 then
            return path
        end
    end

    debugPrint("could not find a project_dir")
    return nil
end

-- Usage example: Start searching from the directory of the current file

function M.chdir()
    local filepath = vim.fn.expand('%:p')
    print(filepath)

    if vim.api.nvim_buf_get_name(0) == '' then
        debugPrint("Empty buffer detected, ignoring project_dir")
        return
    end
    if string.match(filepath, '^sftp://') or  string.match(filepath, '^.*://') then
        debugPrint("sftp/netrw or protocol window detected, ignoring project_dir")
        return
    end

    local dir = vim.fn.fnamemodify(filepath, ':h')

    local project_dir = find_project_dir(dir)
    if project_dir then
        vim.cmd('cd ' .. project_dir)
        print("Set working directory to " .. project_dir)
    end
end

function M.setup()

    local augrp = vim.api.nvim_create_augroup('Project cwd group', { clear = true })
    --local events = { 'UIEnter', 'BufEnter' }

    vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        group = augrp,
        callback = function() require('project').chdir() end,
    })
    --print('leader: ' .. ((vim.g.mapleader == " ") and  "<space>" or  vim.g.mapleader))

    print("mapping  F8")
    vim.keymap.set('n','<F8>',
        function()
            print('keycombo')
            require("project").chdir()
        end,
        { noremap = true, silent = true}
    )
end

return M

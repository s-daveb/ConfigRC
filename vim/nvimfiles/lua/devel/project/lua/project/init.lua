local M = {}

function M.setup()
    vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
            --check for empty buffer
            if vim.api.nvim_buf_get_name(0) == '' then
                return
            end
            local filepath = vim.fn.expand('%:p')

            -- Check if the file path starts with sftp:// to exclude remote directories
            if string.match(filepath, '^sftp://') then
                return
            end

            local dir = vim.fn.fnamemodify(filepath, ':h')

            local function find_project_dir(start_dir)
                while start_dir and start_dir ~= '/' do
                    if vim.fn.isdirectory(start_dir .. '/.git') == 1 then
                        if vim.fn.filereadable(start_dir .. '/CMakeLists.txt') == 1 then
                            return start_dir
                        else
                            return nil
                        end
                    end
                    start_dir = vim.fn.fnamemodify(start_dir, ':h')
                end
                return nil
            end

            local project_dir = find_project_dir(dir)
            if project_dir then
                vim.api.nvim_command('tcd ' .. project_dir)
                -- Uncomment the line below to debug
                -- print("Set working directory to " .. project_dir)
            end
        end
    })
end

return M

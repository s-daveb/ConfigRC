local vim = vim
local M = {}

function M.setup(opts)
    vim.api.nvim_create_autocmd('BufReadPost', {
        callback = function()
            local filepath = vim.fn.expand('%:p')
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
                --print("Set working directory to " .. project_dir)
            end
        end
    })
end

return M

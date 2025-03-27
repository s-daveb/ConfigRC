
local M = {}

function M.setup()
    local opts = {
        model_name = "codegemma:2b-code-q8_0",
        stream_suggestion = true,
        python_command = "python3",
        filetypes = {
            'sh', 'bash', 'zsh',
            'python',
            'cpp', 'cpp.doxygen',
            'c', 'c.doxygen',
            'lua',
            'vim',
            "markdown"
        },
        ollama_model_opts = {
            num_predict = 40,
            temperature = 0.8,
        },
        keymaps = {
            suggestion = '<leader>os',
            reject = '<leader>or',
            insert_accept = '<Tab>',
        },
        fill_in_middle = true
    }
    require('olly').setup(opts)

end

return M

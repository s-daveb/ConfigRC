
local M = {}
local ollama_env = require("ollama-env")

function M.setup()
    local opts = {
        model_name = ollama_env.config.copilot_model,
        stream_suggestion = false,
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
            insert_accept = '<c-return>',
        },
        fill_in_middle = true
    }
    require('olly').setup(opts)
end

return M


local M = {}

function M.setup()
    local ollama_env = require("ollama-env").get_config()
    local opts = {
        model_name = ollama_env.inline_model,
        stream_suggestion = true,
        python_command = "python3",
        filetypes = {'python', 'cpp', 'cpp.doxygen', 'c', 'c.doxygen', 'lua', 'vim', "markdown"},
        ollama_model_opts = {
            num_predict = 40,
            temperature = 0.1,
        },
        keymaps = {
            suggestion = '<leader>os',
            reject = '<leader>or',
            insert_accept = '<Tab>',
        },
    }
    require('OllamaCopilot').setup(opts)

end

return M

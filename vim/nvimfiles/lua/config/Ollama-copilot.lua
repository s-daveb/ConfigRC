
local M = {}

function M.setup()
    --local ollama_env = require("ollama-env").get_config()
    local opts = {
        model_name = "qwen-2.5-coder:1.5b",
        stream_suggestion = true,
        python_command = "python3",
        filetypes = {'python', 'cpp', 'cpp.doxygen', 'c', 'c.doxygen', 'lua', 'vim', "markdown"},
        ollama_model_opts = {
            num_predict = 40,
            temperature = 0.8,
        },
        keymaps = {
            suggestion = '<leader>os',
            reject = '<leader>or',
            insert_accept = '<Tab>',
        },
        fill_in_middle = false
    }
    require('olly').setup(opts)

end

return M

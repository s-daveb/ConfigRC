
local M = {}

    local adapters = require("codecompanion.adapters")
    local ollama_env = require("ollama-env")

    local env_opts = ollama_env.get_config()

    local  function configure_adapters(opts)
        local retval =  {
            ollama_chat = function()
                return adapters.extend("ollama", {
                    name = "ollama_chat",
                    env = {
                        url = "http://" .. opts.host .. ":" .. opts.port,
                    },
                    headers = {
                        ["Content-Type"] = "application/json",
                    },
                    parameters = {
                        sync = true,
                    },
                    schema = {
                        model = {
                            default = opts.chat_model
                        }
                    }
                })
            end,
            ollama_inline = function()
                return adapters.extend("ollama", {
                    name = "ollama_inline",
                    env = {
                        url = "http://" .. opts.host .. ":" .. opts.port,
                    },
                    headers = {
                        ["Content-Type"] = "application/json",
                    },
                    parameters = {
                        sync = true,
                    },
                    schema = {
                        model = {
                            default = opts.inline_model
                        }
                    }
            })
        end,
        ollama_cmd = function()
            return adapters.extend("ollama", {
                name="olama_cmd",
                env = {
                    url = "http://" .. opts.host .. ":" .. opts.port,
                },
                headers = {
                    ["Content-Type"] = "application/json",
                },
                parameters = {
                    sync = true,
                },
                schema = {
                    model = {
                        default = opts.cmd_model
                    }
                }
            })
        end,
        auth_copilot = function()
            return adapters.extend("copilot", {
                name = "auth_copilot",
                env = {
                    XDG_CONFIG_HOME = vim.fn.expand("~/.config"),
                },
                parameters = {
                    sync = true,
                },
            })
        end,
    }

    return retval
end

        function M.setup()
            local configured_adapters = configure_adapters(env_opts)
            require('codecompanion').setup({
            adapters = configured_adapters,
        strategies = {
            chat = {
                adapter = "ollama_chat",
            },
            inline = {
                adapter = "ollama_inline",
            },
            cmd = {
                --adapter = "auth_copilot",
                adapter = "ollama_cmd",
            }
        },
    })
end

return M

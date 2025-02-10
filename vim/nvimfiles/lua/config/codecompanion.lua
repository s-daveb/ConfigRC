
local M = {}
local adapters = require("codecompanion.adapters")


local default_opts = {
    host = "localhost";
    port = 11434;
    model = "phi4:latest";
}

local function split_string(input, delimiter)
        local result = {}
        for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
            table.insert(result, match)
        end
        return result
end


local function normalize_host(opts)
    opts = opts or {}

    if opts.host and string.find(opts.host, ":") then
        opts.port = split_string(opts.host, ":")[2]
        opts.host = split_string(opts.host, ":")[1]
    end

    if not opts.host then
        opts.host = default_opts.host
    end
    if not opts.port then
        opts.port = default_opts.port
    end
    if not opts.model then
        opts.model = default_opts.model
    end

    return opts
end

local  function configure_adapters(opts)
    --vim.notify("Setting up CodeCompanion Model: " .. opts.model)
    --vim.notify("Setting up CodeCompanion Host: " .. opts.host)

    local retval =  {
        ollama_linux = function()
            return adapters.extend("ollama", {
                name = "ollama_linux",
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
                        default = opts.model
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

local uv = vim.loop

local function check_connection_sync(host, port, timeout)
    timeout = timeout or 5000
    local result = nil
    local ip_info = uv.getaddrinfo(host, nil, { family = "inet" })

    if not ip_info or not ip_info[1] then
        print("Couldn't resolve " .. host)
        return false
    end

    local ip = ip_info[1].addr

    local function connect_handler(sock)
        sock:connect(ip, port, function(err)
            if err then
                print("Connect error: " .. err)
                result = false
            else
                print("Connect success")
                result = true
            end
            sock:close()
        end)
    end

    local sock = uv.new_tcp()
    connect_handler(sock)

    local elapsed = 0
    local interval = 10 -- ms
    while result == nil and elapsed < timeout do
        uv.run("nowait")
        uv.sleep(interval)
        elapsed = elapsed + interval
    end

    if result == nil then
        return false
    end

    return result
end

local function try_ollama_env()
    local opts = {
        host = os.getenv("OLLAMA_HOST") or default_opts.host,
        port = 0,
        model = os.getenv("OLLAMA_DEFAULT_MODEL") or default_opts.model,
    }

    opts = normalize_host(opts)

    if not check_connection_sync(opts.host, opts.port) then
        opts = default_opts
    end

    return opts
end


function M.setup(opts)
    if opts == {} then opts = nil end

    local calculated_opts = opts or try_ollama_env()

    calculated_opts = normalize_host(calculated_opts)
    --
    -- initialize only after lazy loading with lua nvim autocmd
    local configured_adapters = configure_adapters(calculated_opts)

    require('codecompanion').setup({
        adapters = configured_adapters,
        strategies = {
            chat = {
                adapter = "ollama_linux",
            },
            inline = {
                adapter = "ollama_linux",
            },
            cmd = {
                adapter = "auth_copilot",
            }
        },
    })
end

return M


local M = {}
local codecompanion = require("codecompanion")
local adapters = require("codecompanion.adapters")

local default_opts = {
    host = "localhost";
    port = 11434;
    model = "phi3:latest";
}

local function split_string(input, delimiter)
        local result = {}
        for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
            table.insert(result, match)
        end
        return result
end


local function normalize_host(opts)
    opts = opts

    if opts.host  and string.find(opts.host, ":") then
        opts.port = split_string(opts.host, ":")[2]
        opts.host = split_string(opts.host, ":")[1]
    else
        opts.host = opts.host or default_opts.host
    end
    if not opts.port then
        opts.port = default_opts.port
    end

    return opts
end

local  function configure_adapters(opts)

    return {
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
end

local function check_connection_sync(host, port, timeout)
    timeout = timeout or 1000
    local socket = vim.loop.new_tcp()
    local result = nil
    local ip = nil
    local ip_info = vim.loop.getaddrinfo(host)

    if not ip_info then
        return false
    else
        ip = ip_info[1].addr
    end

    -- Start connection
    socket:connect(ip, port, function(err)
        if err then
            result = false
        else
            result = true
        end
        socket:close()
    end)

    -- Wait for the result
    vim.wait(timeout, function() return result ~= nil end, 10) -- Wait up to 5000ms, checking every 10ms

    -- If no result after the timeout, consider it a failure
    return result or false
end

local function try_ollama_env()
    local opts = {
        host = os.getenv("OLLAMA_HOST") or default_opts.host,
        port = 0,
    }
    opts= normalize_host(opts)
    opts = vim.tbl_extend("force", default_opts, opts)

    if not check_connection_sync(opts.host, opts.port) then
            return nil
    end

    return opts
end


function M.setup(opts)
     opts = normalize_host(opts) or {}


    local env_opts = try_ollama_env() or {}

    if env_opts then
        opts = vim.tbl_extend("force", env_opts, opts)
    end

--    print("Code Companion connecting on " .. opts.host .. ":" .. opts.port)

    codecompanion.setup({
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
        adapters = configure_adapters(opts),
    })
end

return M

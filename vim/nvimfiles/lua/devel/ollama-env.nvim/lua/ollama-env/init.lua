
local M = {}

local default_opts = {
    host         = "localhost",
    port         = 11434,
    inline_model = "phi4:latest",
    chat_model   = "phi4:latest",
    cmd_model    = "phi4:latest",
}


local function normalize_opts(opts)
    opts = opts or {}

    local function split_string(input, delimiter)
        local result = {}
        for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
            table.insert(result, match)
        end
        return result
    end

    if opts.host and opts.host:find(":") then
        local parts = split_string(opts.host, ":")
        opts.host = parts[1]
        opts.port = tonumber(parts[2]) or default_opts.port
    end

    if not opts.host then
        opts.host = default_opts.host
    end

    if not opts.port or opts.port == 0 then
        opts.port = default_opts.port
    end

    if not opts.chat_model then
        opts.chat_model = default_opts.chat_model
    end

    if not opts.inline_model then
        opts.inline_model = default_opts.inline_model
    end

    if not opts.cmd_model then
        opts.cmd_model = default_opts.cmd_model
    end

    return opts
end

local function check_connection_sync(host, port, timeout)
    timeout = timeout or 5000
    local result = nil

    local ip_info = vim.loop.getaddrinfo(host, nil, { family = "inet" })
    if not ip_info or not ip_info[1] then
        print("Couldn't resolve " .. host)
        return false
    end

    local ip = ip_info[1].addr
    local sock = vim.loop.new_tcp()
    sock:connect(ip, port, function(err)
        if err then
            print("Connect error: " .. err)
            result = false
        else
            result = true
        end
        sock:close()
    end)

    local elapsed = 0
    local interval = 10 -- milliseconds
    while result == nil and elapsed < timeout do
        vim.loop.run("nowait")
        vim.loop.sleep(interval)
        elapsed = elapsed + interval
    end

    if result == nil then
        return false
    end

    return result
end

local function try_ollama_env()
    local opts = {
        host         = os.getenv("OLLAMA_HOST") or default_opts.host,
        port         = 0,  -- if not specified, will be fixed by normalize_opts
        chat_model   = os.getenv("OLLAMA_DEFAULT_MODEL") or default_opts.chat_model,
        inline_model = os.getenv("OLLAMA_NVIM_INLINE_MODEL") or default_opts.inline_model,
        cmd_model    = os.getenv("OLLAMA_NVIM_CMD_MODEL") or default_opts.cmd_model,
    }

    opts = normalize_opts(opts)

    if not check_connection_sync(opts.host, opts.port) then
        opts = default_opts
    end

    return opts
end

--- Setup ollama-env.
--- @param opts table: A table with keys `host`, `port`, `chat_model`, `inline_model`, and `cmd_model`.
function M.setup(opts)
    if opts == {} then opts = nil end

    opts = opts or try_ollama_env()
    opts = normalize_opts(opts)
    if not check_connection_sync(opts.host, opts.port) then
        echo "Failed to connect"
        opts = default_opts
    end

    M.config = opts -- Store config inside the module
end

--- Retrieve the current configuration.
--- @return table: The stored ollama configuration.
function M.get_config()
    return M.config or default_opts
end

return M

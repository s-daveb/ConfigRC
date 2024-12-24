local M = {}

-- Timer to handle delayed hover
local hover_timer = nil
-- Track the last known cursor position
local last_cursor_pos = nil

-- Function to initiate hover after a delay
function M.async_hover_diagnostic()
    -- Get the current cursor position
    local current_pos = vim.api.nvim_win_get_cursor(0)

    -- If the cursor has moved, cancel any existing timer
    if hover_timer and (not last_cursor_pos or
        current_pos[1] ~= last_cursor_pos[1] or
        current_pos[2] ~= last_cursor_pos[2]) then
        hover_timer:stop()
        hover_timer:close()
        hover_timer = nil
    end

    -- Update the last known cursor position
    last_cursor_pos = current_pos

    -- Start a new timer for the hover action
    hover_timer = vim.loop.new_timer()
    hover_timer:start(2000, 0, vim.schedule_wrap(function()
        M.hover_diagnostic()
    end))
end

-- Function to display hover or diagnostic information
function M.hover_diagnostic()
    -- Retrieve diagnostics at the current cursor position
    local line_diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })

    if vim.tbl_isempty(line_diagnostics) then
        -- No diagnostics; show hover information
        vim.lsp.buf.hover()
    else
        -- Diagnostics present; show diagnostic popup
        vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
    end
end

-- Function to cancel the hover popup if the cursor moves
function M.cancel_hover()
    if hover_timer then
        hover_timer:stop()
        hover_timer:close()
        hover_timer = nil
    end
end

-- Setup autocommands for CursorHold and CursorMoved events
local function setup_hover_diagnostics()
    vim.api.nvim_create_autocmd("CursorHold", {
        group = vim.api.nvim_create_augroup("HoverDiagnostics", { clear = true }),
        callback = M.async_hover_diagnostic,
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
        group = vim.api.nvim_create_augroup("CancelHoverDiagnostics", { clear = true }),
        callback = M.cancel_hover,
    })
end

-- Load function to initialize the module
function M.load()
    -- Set the update time for CursorHold event
    vim.o.updatetime = 500

    -- Configure diagnostic display settings
    vim.diagnostic.config({
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            source = "always",
            border = "rounded",
        },
    })

    -- Setup hover diagnostics
    setup_hover_diagnostics()

    -- Initialize LSP providers
    require('config.lsp.providers').init()
end

return M


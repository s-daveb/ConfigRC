
local M = {}

-- Timer to handle delayed hover
local hover_timer = nil
-- Track the last known cursor position
local last_cursor_pos = nil

-- Function to initiate hover after a delay
function M.async_hover_diagnostic()
    local current_pos = vim.api.nvim_win_get_cursor(0)

    if hover_timer and (not last_cursor_pos or
        current_pos[1] ~= last_cursor_pos[1] or
        current_pos[2] ~= last_cursor_pos[2]) then
        hover_timer:stop()
        hover_timer:close()
        hover_timer = nil
    end

    last_cursor_pos = current_pos

    hover_timer = vim.loop.new_timer()
    hover_timer:start(500, 0, vim.schedule_wrap(function()
        M.hover_diagnostic()
    end))
end

-- Function to display hover or diagnostic information
function M.hover_diagnostic()
    local line_diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })

    if vim.tbl_isempty(line_diagnostics) then
        vim.lsp.buf.hover()
    else
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

-- Function to enable hover diagnostics
local function enable_hover_diagnostics()
    -- if group already exists, do nothing
    local autocommands = vim.api.nvim_get_autocmds({
        group = "ToggleHoverDiagnostics",

    })
    --if #autocommands > 0 then
    --    vim.notify("hints setup aborted!!!")
    --    return
    --end

    vim.api.nvim_create_autocmd("CursorHold", {
        group = vim.api.nvim_create_augroup("HoverDiagnostics", { clear = true }),
        callback = M.async_hover_diagnostic,
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
        group = vim.api.nvim_create_augroup("CancelHoverDiagnostics", { clear = true }),
        callback = M.cancel_hover,
    })
end

-- Function to disable hover diagnostics
local function disable_hover_diagnostics()
    -- if group does not exist, do nothing
   local autocommands = vim.api.nvim_get_autocmds({
        group = "ToggleHoverDiagnostics",

    })
    if #autocommands == 0 then
        return
    end

    pcall(vim.api.nvim_del_augroup_by_name, "HoverDiagnostics")
end

-- Public method to toggle hover diagnostics
function M.toggle_hints(enable)
    if enable then
        enable_hover_diagnostics()
    else
        disable_hover_diagnostics()
    end
end

local function setup_bufread_autocmd()
    local incompatible_filetypes = {
        "NvimTree",
        "fzf",
        "fugitive",
        "qf",
        "help",
        "packer",
        "startify",
        "dashboard",
        "codecompanion",
        "copilot"
    }
    -- Setup autocommands for toggling hover diagnostics based on filetype
    vim.api.nvim_create_autocmd({"BufReadPost", "BufWinEnter"}, {
        group = vim.api.nvim_create_augroup("ToggleHoverDiagnostics", { clear = true }),
        callback = function()
            if vim.tbl_contains(incompatible_filetypes, vim.bo.filetype) then
                M.toggle_hints(false) -- Disable hover diagnostics for incompatible filetypes
            else
                M.toggle_hints(true) -- Enable hover diagnostics for other filetypes
            end
        end,
    })

    vim.api.nvim_create_autocmd({'BufWinEnter','LspAttach'}, {
      desc = 'Setup LSP keymaps for current buffer',
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        require('keymaps.lsp').set_keys(nil, bufnr)
      end,
    })

end

-- Load function to initialize the module
function M.load()
    vim.o.updatetime = 500

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

    setup_bufread_autocmd()
    -- Initialize LSP providers
    require('config.lsp.providers').init()
end

return M



local M = {}

M.debug =  false

local function debugMsg(...)
    if (M.debug) then
        print(...)
    end
end


local default_term_theme = "dracula"
local default_tmux_theme = "dracula-soft"

local default_gui_theme_light = "dhampir"
local default_gui_theme_dark = "dracula"
local default_gui_theme = default_gui_theme_dark

M.colorscheme = default_term_theme

local function get_os_and_arch()
    local raw_os_name = 'unknown'
    local raw_arch_name = 'unknown'

    -- Check OS
    if package.config:sub(1,1) == '\\' then
        -- Windows
        raw_os_name = os.getenv('OS') or raw_os_name
        raw_arch_name = os.getenv('PROCESSOR_ARCHITECTURE') or raw_arch_name
    else
        -- Unix-like
        local uname_handle = io.popen('uname -s')
        if(uname_handle) then
            raw_os_name = uname_handle:read('*l')
            uname_handle:close()
        end

        local arch_handle = io.popen('uname -m')
        if(arch_handle) then
            raw_arch_name = arch_handle:read('*l')
            arch_handle:close()
        end
    end

    if (raw_os_name == "") then raw_os_name = "unknown" end
    if (raw_arch_name == "") then raw_arch_name = "unknown" end

    return raw_os_name, raw_arch_name
end

function M.isDarkMode()
    local result = false

    local os_name, arch_name = get_os_and_arch()
    -- Check if running on macOS (Darwin)
    if os_name == "Darwin" then
        -- Execute defaults command as before
        local handle = io.popen('defaults read -g AppleInterfaceStyle 2>/dev/null')
        if (handle) then
            local output = handle:read('*a')
            handle:close()
            if output == "" then output = "light" end
            debugMsg('>>> ' .. output .. ' <<<')
            return (output:gsub('%s+', '') == 'Dark')
        end
    else
        -- For other operating systems, check via uname and XDG themes
        local handle = io.popen('uname -s 2>/dev/null')
        if (handle) then
            local output = handle:read('*a')
            handle:close()
            local osType = output:gsub('%s+', '')

            -- Check for Linux/FreeBSD and XDG dark mode support
            if osType == "Linux" or osType == "FreeBSD" then
                -- Assume dark mode if XDG session type is set to dark
                return os.getenv("XDG_SESSION_TYPE") == "dark"
            end
        end
    end
    return result
end


function M.make_themeset(term, gui, tmux)
    return {
        term =  term or default_term_theme,
        gui =  gui or default_gui_theme,
        tmux =  tmux or default_tmux_theme,
    }
end

function M.set(themeset, preexec)

    -- Set default_gui_theme based on background
    debugMsg("Current background:", vim.o.background)

    if (not M.isDarkMode()) then
        debugMsg("Setting default_gui_theme to light theme:", default_gui_theme_light)
        default_gui_theme = default_gui_theme_light
    else
        debugMsg("Using dark theme for GUI:", default_gui_theme_dark)
    end

    local keymaps = require('keymaps.colors')

    -- Check if running in GUI
    debugMsg("Running in GUI?", (vim.fn.has('gui_running') == 1))
    M.is_gui = (vim.fn.has('gui_running') == 1) and true or false


    debugMsg("themeset before assignment:", themeset)
    themeset = themeset or os.getenv("NEOVIDE_BG") or nil
    debugMsg("themeset after assignment:", themeset)

    if themeset == nil then
        debugMsg("themeset is nil; creating default themeset")
        themeset = M.make_themeset(nil, nil, nil)  -- Create a default themeset if none is provided
    end

    -- Set colorscheme with fallback
    debugMsg("Setting M.colorscheme to:", themeset.gui)
    M.colorscheme = themeset.gui

    if (preexec) then
        preexec()
    end

    -- Add a check to ensure colorscheme is not nil before using it
    debugMsg("Attempting to set colorscheme:", M.colorscheme)
    if M.colorscheme ~= nil then
        debugMsg("Setting colorscheme command:", "colorscheme " .. M.colorscheme)
        vim.cmd("colorscheme " .. M.colorscheme)
    else
        debugMsg("Error: No valid colorscheme found")
    end

    debugMsg("Loading keymaps...")
    keymaps.load()
end

return M


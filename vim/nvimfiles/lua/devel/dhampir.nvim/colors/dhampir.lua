if vim.g.colors_name then
    vim.cmd("hi clear")
end

if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "dhampir"

if (vim.opt.background:get() ~= "light") then
    vim.opt.background = "light"
end

local colors = {
    foreground    = "#202021",
    red           = "#CC3B2C",
    orange        = "#A34F15",
    yellow        = "#837116",
    green         = "#14730C",
    cyan          = "#036B98",
    blue          = "#285278",
    pink          = "#A3144F",
    purple        = "#654BCA",
    background    = "#F5F7EE",
    selection     = "#D0D0DF",
    comment       = "#645E98",
    line_highlight = "#DDDFEF",
    mid_gray      = "#4B4B4B",
    off_white     = "#F1F1F1",
}

local highlights = {
    -- Editor UI
    Normal        = { fg = colors.foreground, bg = colors.background },
    NormalNC      = { fg = colors.foreground, bg = colors.background },
    Comment       = { fg = colors.comment, italic = true },
    Cursor        = { bg = colors.comment },
    CursorLine    = { bg = colors.line_highlight },
    CursorLineNr  = { fg = colors.purple, bg = colors.line_highlight, bold = true },
    ColorColumn   = { bg = colors.line_highlight },
    LineNr        = { fg = colors.comment, bg = colors.background },
    SignColumn    = { bg = colors.background },
    StatusLine    = { fg = colors.foreground, bg = colors.selection },
    StatusLineNC  = { fg = colors.comment, bg = colors.background },
    VertSplit     = { fg = colors.selection, bg = colors.selection },
    Pmenu         = { fg = colors.foreground, bg = colors.selection },
    PmenuSel      = { fg = colors.background, bg = colors.purple },
    Visual        = { bg = colors.selection },
    Search        = { fg = colors.background, bg = colors.yellow },
    IncSearch     = { fg = colors.background, bg = colors.orange },
    Directory     = { fg = colors.purple, bold = true },
    NormalFloat = {  bg = nil },
    Title         = { bg = nil, fg = colors.foreground },

    -- Diff colors
    Removed = { bg = nil, fg = colors.red },
    Added   = { bg = nil, fg = colors.green },
    NeoTreeGitModified =  { bg = nil, fg = colors.orange, italic = true},

    -- Syntax Highlighting
    String        = { fg = colors.yellow },
    Constant      = { fg = colors.purple },
    Number        = { fg = colors.purple },
    Keyword       = { fg = colors.pink, bold = true},
    Function      = { fg = colors.green },
    Identifier    = { fg = colors.orange },
    Type          = { fg = colors.cyan },
    Statement     = { fg = colors.pink },
    PreProc       = { fg = colors.pink },
    Special       = { fg = colors.blue },
    Error         = { fg = colors.red, bold = true },
    Todo          = { fg = colors.foreground, bg = colors.yellow, bold = true },

    -- Treesitter support
    ["@function"]         = { fg = colors.green },
    ["@method"]           = { fg = colors.green },
    ["@keyword"]          = { fg = colors.pink, bold = false, italic = false },
    ["@type"]             = { fg = colors.cyan },
    ["@variable"]         = { fg = colors.green, bold = false, italic = false },
    ["@parameter"]        = { fg = colors.orange },
    ["@comment"]          = { fg = colors.comment, italic = true },
    ["@string"]           = { fg = colors.yellow },
    ["@number"]           = { fg = colors.purple },
    ["@constant"]         = { fg = colors.purple },
    ["@operator"]         = { fg = colors.pink },
    ["@punctuation"]      = { fg = colors.foreground },
    ["@tag"]              = { fg = colors.pink },
    ["@tag.attribute"]    = { fg = colors.green },
    ["@text.title"]       = { fg = colors.purple, bold = true },
    ["@text.strong"]      = { fg = colors.foreground, bold = true },
    ["@text.emphasis"]    = { fg = colors.foreground, italic = true },
    ["@text.underline"]   = { fg = colors.foreground, underline = true },

    -- Diff
    DiffAdd       = { fg = colors.green, bg = "#E6FFED" },
    DiffChange    = { fg = colors.yellow, bg = "#FFF5B1" },
    DiffDelete    = { fg = colors.red, bg = "#FFDCE0" },
    DiffText      = { fg = colors.blue, bg = "#D1ECFF", bold = true },

    -- Diagnostics
    DiagnosticError = { fg = colors.red },
    DiagnosticWarn  = { fg = colors.orange },
    DiagnosticInfo  = { fg = colors.blue },
    DiagnosticHint  = { fg = colors.cyan },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
    DiagnosticUnderlineWarn  = { undercurl = true, sp = colors.orange },
    DiagnosticUnderlineInfo  = { undercurl = true, sp = colors.blue },
    DiagnosticUnderlineHint  = { undercurl = true, sp = colors.cyan },

    -- Git Signs
    GitGutterAdd    = { fg = colors.green },
    GitGutterChange = { fg = colors.yellow },
    GitGutterDelete = { fg = colors.red },
}

for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, {
        fg        = opts.fg or "NONE",
        bg        = opts.bg or "NONE",
        bold      = opts.bold,
        italic    = opts.italic,
        underline = opts.underline,
        undercurl = opts.undercurl,
        sp        = opts.sp,
    })
end


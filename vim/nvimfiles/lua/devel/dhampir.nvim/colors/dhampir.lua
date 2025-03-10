vim.cmd("hi clear")

if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.o.background = "light"
vim.g.colors_name = "dhampir"

-- Original palette, plus a new 'string_bg' color
local colors = {
    foreground    = "#202021",
    red           = "#CC2019",
    orange        = "#A34F15",
    yellow        = "#837116",
    green         = "#14730C",
    cyan          = "#036B98",
    blue          = "#285278",
    pink          = "#A3144F",
    purple        = "#654BCA",
    background    = "#FAFAFB",
    selection     = "#DBC358",
    comment       = "#645E98",
    line_highlight = "#DDDFEF",
    mid_gray      = "#4B4B4B",
    off_white     = "#F1F1F1",

    -- For strings
    gold_accent   = "#B2690D",
    darkened_bg   = "#DCDCDB"
}

local highlights = {
    -- Editor UI
    Normal        = { fg = colors.foreground, bg = colors.background },
    NormalNC      = { fg = colors.foreground, bg = colors.background },
    Comment       = { fg = colors.orange, italic = true },
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
    NormalFloat   = { bg = nil },
    Title         = { fg = colors.foreground, bg = nil },


    LspInlayHint       = { fg = colors.mid_gray, bg=colors.darkened_bg, bold=false, italic = true },

    -- Diff colors
    Removed            = { fg = colors.red },
    Added              = { fg = colors.green },
    NeoTreeGitModified = { fg = colors.orange, italic = true },

    -- Syntax (Preferring Vim highlight groups over TreeSitter)
    String       = { fg = colors.gold_accent,  bg=colors.off_white, bold = false, italic = true },
    Constant     = { fg = colors.orange, bold = true, italic = true },
    Number       = { fg = colors.mid_gray, italic = true },
    Keyword      = { fg = colors.red, bold = false },
    Function     = { fg = colors.red, italics = false },
    Identifier   = { fg = colors.mid_gray, italic = true },
    Type         = { fg = colors.mid_gray, italic = false, bold = false },
    Statement    = { fg = colors.mid_gray },
    PreProc      = { fg = colors.cyan, italic = true },
    Special      = { fg = colors.mid_gray },
    Error        = { fg = colors.mid_gray, bold = true },
    Todo         = { fg = colors.foreground, bg = colors.mid_gray, bold = true },

    -- Diff
    DiffAdd       = { fg = colors.green, bg = "#E6FFED" },
    DiffChange    = { fg = colors.yellow, bg = "#FFF5B1" },
    DiffDelete    = { fg = colors.red,    bg = "#FFDCE0" },
    DiffText      = { fg = colors.blue,   bg = "#D1ECFF", bold = true },

    -- Diagnostics
    DiagnosticError          = { fg = colors.red },
    DiagnosticWarn           = { fg = colors.orange },
    DiagnosticInfo           = { fg = colors.blue },
    DiagnosticHint           = { fg = colors.cyan },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
    DiagnosticUnderlineWarn  = { undercurl = true, sp = colors.orange },
    DiagnosticUnderlineInfo  = { undercurl = true, sp = colors.blue },
    DiagnosticUnderlineHint  = { undercurl = true, sp = colors.cyan },

    -- Git Signs
    GitGutterAdd    = { fg = colors.green },
    GitGutterChange = { fg = colors.yellow },
    GitGutterDelete = { fg = colors.red },

    -- Additional C++-specific TreeSitter highlights
    ["@preproc.cpp"]                    = { fg = colors.purple, bold = true, italic = true },
    ["@function.macro.cpp"]             = { fg = colors.purple, bold = true, italic = true },
    ["@keyword.import.cpp"]             = { fg = colors.purple, bold = false, italic = true },
    ["@keyword.directive.define.cpp"]   = { fg = colors.purple, bold = true, italic = true },
    ["@include.cpp"] = { fg = colors.cyan, italic = true },
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

vim.o.background = "light"
vim.g.colors_name = "dhampir"

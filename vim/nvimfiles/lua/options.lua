------------------
-- options.lua  --
------------------

vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim

vim.opt.updatetime = 300

-- Tab
vim.opt.tabstop = 8                 -- number of visual spaces per TAB
vim.opt.softtabstop = 8             -- number of spacesin tab when editing
vim.opt.shiftwidth = 8              -- indent 8 spaces when using >>, <<, ==, etc. 
vim.opt.expandtab = false           -- tabs are spaces, mainly because of python

-- Highlights
vim.opt.colorcolumn = "80"          -- highlight column 80

-- UI config
vim.opt.number = true               -- show absolute number
vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true           -- open new vertical split bottom
vim.opt.splitright = true           -- open new horizontal splits right
vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = true            -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

-- Completion
vim.opt.completeopt =
    {'menu', 'menuone', 'noselect'} -- better completion experience

-- Enable persistent undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undo"

-- Enable swap file
vim.opt.swapfile = true
vim.opt.directory = os.getenv("HOME") .. "/.cache/nvim/swap"

vim.opt.wrap = false

-- Enable view saving
vim.opt.viewoptions = "cursor,folds,slash,unix" -- Customize what is saved in views
vim.opt.viewdir = os.getenv("HOME") .. "/.cache/nvim/view" -- Set the view directory

-- Automatically save views when leaving a buffer
vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "*",
    command = "silent! mkview!"
})

-- Automatically load views when entering a buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    command = "silent! loadview"
})

-- Highlight trailing whitespace as a syntax error
vim.fn.matchadd('DiagnosticUnderlineError', [[\s\+$]])

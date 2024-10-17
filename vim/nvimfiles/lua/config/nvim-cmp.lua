local vim = vim
local M = {}

local luasnip = require("luasnip")
local cmp = require("cmp")

local M = {}

local function is_cursor_at_word_end()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    -- Check if the previous character is non-whitespace and the current character is whitespace or end of line
    return col > 1 and line:sub(col - 1, col - 1):match('%S') and (col > #line or line:sub(col, col):match('%s'))
end

local completion_timer = nil

local function start_async_completion()
    -- Cancel any existing timer
    if completion_timer then
        completion_timer:stop()
        completion_timer:close()
    end
    completion_timer = vim.loop.new_timer()
    completion_timer:start(1000, 0, vim.schedule_wrap(function()
        if completion_timer then
            if is_cursor_at_word_end() then
                cmp.complete()
            end
        end
    end))
end

function M.load(opts)
    local opts = opts or {}

    -- Set up an autocmd for CursorHoldI event to start the completion timer
    vim.api.nvim_create_autocmd("CursorHoldI", {
        callback = function()
            start_async_completion()
        end
    })
    -- Set up autocmds to restart the timer whenever the cursor moves
    vim.api.nvim_create_autocmd({"CursorMovedI", "InsertLeave"}, {
        callback = function()
            if completion_timer then
                completion_timer:stop()
                completion_timer:close()
                completion_timer = nil
            end
        end
    })

    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = cmp.mapping.preset.insert({
            -- Use <C-b/f> to scroll the docs
            ['<C-b>'] = cmp.mapping.scroll_docs( -4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            -- Use <C-k/j> to switch in items
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            -- Use <CR>(Enter) to confirm selection
            -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<CR>'] = cmp.mapping.confirm({ select = true }),

            -- A super tab
            -- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
            ["<Tab>"] = cmp.mapping(function(fallback)
                -- Hint: if the completion menu is visible select next one
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "s" }), -- i - insert mode; s - select mode
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),

        -- Let's configure the item's appearance
        -- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
        formatting = {
            -- Set order from left to right
            -- kind: single letter indicating the type of completion
            -- abbr: abbreviation of "word"; when not empty it is used in the menu instead of "word"
            -- menu: extra text for the popup menu, displayed after "word" or "abbr"
            fields = { 'abbr', 'menu' },

            -- customize the appearance of the completion menu
            format = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = '[Lsp]',
                    luasnip = '[Luasnip]',
                    buffer = '[File]',
                    path = '[Path]',
                })[entry.source.name]
                return vim_item
            end,
        },

        -- Set source precedence
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },    -- For nvim-lsp
            { name = 'luasnip' },     -- For luasnip user
            { name = 'buffer' },      -- For buffer word completion
            { name = 'path' },        -- For path completion
        })
    })
end


return M

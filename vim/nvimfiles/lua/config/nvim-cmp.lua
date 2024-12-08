local vim = vim
local M = {}

local luasnip = require("luasnip")
local cmp = require("cmp")

local default_opts = {
        completion = {
            autocomplete = { autocomplete = false },
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        formatting = {
            fields = { 'abbr', 'menu' },
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
        sources = cmp.config.sources({
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
        }),
    }


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
    opts = opts or {}
    local cmp_opts = vim.tbl_deep_extend("force", default_opts, opts)

   --Set up an autocmd for CursorHoldI event to start the completion timer
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

    cmp.setup(cmp_opts)
end


return M

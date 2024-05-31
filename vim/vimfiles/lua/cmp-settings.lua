local vim = vim
local module = {}
local cmp = require('cmp')

--local snippy = require'snippy'

local keymappings = {
  ['<C-B>'] = cmp.mapping.scroll_docs(-4),
  ['<C-F>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<ESC>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}

--local function setupSnippy()
--	local has_words_before = function()
--  	unpack = unpack or table.unpack
--  	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--  	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--	end
--
--	keymappings["<Tab>"] = cmp.mapping(function(fallback)
--    if cmp.visible() then
--      cmp.select_next_item()
--    elseif snippy.can_expand_or_advance() then
--      snippy.expand_or_advance()
--    elseif has_words_before() then
--      cmp.complete()
--    else
--      fallback()
--    end
--  end, { "i", "s" })
--
--  keymappings["<S-Tab>"] = cmp.mapping(function(fallback)
--    if cmp.visible() then
--      cmp.select_prev_item()
--    elseif snippy.can_jump(-1) then
--      snippy.previous()
--    else
--      fallback()
--    end
--  end, { "i", "s" })
--
--	local snippetdir_list = { "~/.vim-plug/vim-snippets","~/.vim/UltiSnips" }
--	local expanded_snippet_dirs = {}
--
--	for _, element in ipairs(snippetdir_list) do
--  	expanded_snippet_dirs[#expanded_snippet_dirs + 1] = vim.fn.expand(element)
--	end
--	local snippet_dirs =  table.concat(expanded_snippet_dirs, ",")
--
--	snippy.setup({snippetdir_dirs = snippet_dirs})
--end

function module.load()
--	setupSnippy()

	cmp.setup({
		snippet = {
  		expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				--snippy.expand_snippet(args.body)
  		end,
		},
		window = {
  		completion = cmp.config.window.bordered(),
  		documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert(keymappings),
		sources = cmp.config.sources({
  		{ name = 'nvim_lsp' },
			{ name = 'vsnip' },
  		{ name = 'buffer' },
  		--{ name = 'ultisnips' }, -- For ultisnips users.
		})
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
  		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
		}, {
  		{ name = 'buffer' },
		})
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
  		{ name = 'buffer' }
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
  		{ name = 'path' }
		},
		{
  		{ name = 'cmdline' }
		}),
		matching = { disallow_symbol_nonprefix_matching = false }
	})
end

return module
-- vim: set noet sts=0 sw=2 ts=2 foldmethod=indent :

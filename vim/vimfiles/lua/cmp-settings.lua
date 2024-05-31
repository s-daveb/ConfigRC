local vim = vim
local module = {}
local cmp = require('cmp')

function module.load()
	cmp.setup({
		snippet = {
  		-- REQUIRED - you must specify a snippet engine
  		expand = function(args)
    		vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  		end,
		},
		window = {
  		completion = cmp.config.window.bordered(),
  		documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
  		['<C-B>'] = cmp.mapping.scroll_docs(-4),
  		['<C-F>'] = cmp.mapping.scroll_docs(4),
  		['<C-Space>'] = cmp.mapping.complete(),
  		--['<C-X>o'] = cmp.mapping.complete(),
  		['<ESC>'] = cmp.mapping.abort(),
  		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
  		{ name = 'nvim_lsp' },
  		{ name = 'ultisnips' }, -- For ultisnips users.
  		{ name = 'buffer' },
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
		}, {
  		{ name = 'cmdline' }
		}),
		matching = { disallow_symbol_nonprefix_matching = false }
	})
end


return module
-- vim: set noet sts=0 sw=2 ts=2 :

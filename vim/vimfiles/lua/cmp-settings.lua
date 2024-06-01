local vim = vim
local module = {}
local cmp = require('cmp')

local keymappings = {
  ['<C-B>'] = cmp.mapping.scroll_docs(-4),
  ['<C-F>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(), -- Manual completion mapping
  -- Map <ESC> to a function that also exits insert mode, so you don't have to
	-- double-ESC when a completion popup comes up
  ['<ESC>'] = function(fallback)
  	if(cmp.visible()) then
			cmp.close()
			vim.cmd("stopinsert")
		else
			fallback()
		end
  end,
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}


local function loadSources()
	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources(
  		{{ name = 'git' }},   --  requires 'petertriho/cmp-git'
			{{ name = 'buffer' }}
		)
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {{ name = 'buffer' }}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(
			{{ name = 'path' }},
			{{ name = 'cmdline' }}
		),
		matching = { disallow_symbol_nonprefix_matching = false }
	})
end


function module.load()
	cmp.setup({
		completion = {
			autocomplete = false,
		},
		snippet = {
  		expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
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
		})
	})

	-- vim.api.nvim_create_autocmd({"CursorHoldI","CursorHold"}, {
	vim.api.nvim_create_autocmd("CursorHoldI", {
  	pattern = "*",
  	callback = function()
    	cmp.complete()
  	end
	})

	loadSources()
end

return module
-- vim: set noet sts=0 sw=2 ts=2 foldmethod=indent foldlevel=1 foldminlines=10 :

local vim = vim
local module = {}
local cmp = require('cmp')

local completion_timer = nil

local function is_cursor_at_word_end()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    -- Check if the previous character is non-whitespace and the current character is whitespace or end of line
    return col > 1 and line:sub(col - 1, col - 1):match('%S') and (col > #line or line:sub(col, col):match('%s'))
end

local function start_completion_timer()
  -- Cancel any existing timer
  if completion_timer then
    completion_timer:stop()
    completion_timer:close()
  end

  completion_timer = vim.loop.new_timer()
  completion_timer:start(600, 0, vim.schedule_wrap(function()
		if is_cursor_at_word_end() then
      if completion_timer then
      	cmp.complete()
    	end
    end
  end))
end

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
  ['<CR>'] = cmp.mapping.confirm(
  	{ select = false } -- Set `select` to `false` or you'll never be able to enter a new line again
	),
}

--local ultisnips_loaded,cmp_ultisnips_mappings = pcall(require,"cmp_nvim_ultisnips.mappings")
--if ultisnips_loaded then
--	keymappings["<Tab>"] = cmp.mapping(
--    function(fallback)
--      cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
--    end,
--    { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
--  )
--  keymappings["<S-Tab>"] = cmp.mapping(
--    function(fallback)
--      cmp_ultisnips_mappings.jump_backwards(fallback)
--    end,
--    { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
--  )
--end

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
				--vim.fn["UltiSnips#Anon"](args.body)
				--require('snippy').expand_snippet(args.body)
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
			--{ name = 'ultisnips' },
			--{ name = 'snippy' },
  		{ name = 'buffer' },
		})
	})

	-- Set up an autocmd for CursorHoldI event to start the completion timer
	vim.api.nvim_create_autocmd("CursorHoldI", {
    callback = start_completion_timer,
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

	loadSources()
end

return module
-- vim: set noet sts=0 sw=2 ts=2 foldmethod=indent foldlevel=1 foldminlines=10 :

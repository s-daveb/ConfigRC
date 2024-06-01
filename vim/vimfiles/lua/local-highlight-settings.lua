local vim = vim
local module = {}

local local_highlight = require('local-highlight')

function module.load()
	local_highlight.setup({
		--file_types = {'python', 'cpp'}, -- If this is given only attach to this
		-- OR attach to every filetype except:
		-- disable_file_types = {'tex'},
		hlgroup = 'Visual',
		cw_hlgroup = 'Underlined',
		insert_mode = true,
		min_match_len = 1,
		max_match_len = math.huge,
		highlight_single_match = true,
	})

	vim.api.nvim_create_autocmd('BufRead', {
		pattern = {'*.*'},
		callback = function(data)
			local_highlight.attach(data.buf)
		end
  })

	vim.opt.updatetime = 400 -- ms
end


return module

-- vim: set ts=2 sts=2 sw=2 noet :

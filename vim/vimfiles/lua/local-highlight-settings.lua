local module = {}

function module.load()
	local local_highlight_plugin = require('local-highlight');

	local_highlight_plugin.setup({
    		--file_types = {'python', 'cpp'}, -- If this is given only attach to this
    		-- OR attach to every filetype except:
    		-- disable_file_types = {'tex'},
    		hlgroup = 'Visual',
    		cw_hlgroup = 'Search',
    		-- Whether to display highlights in INSERT mode or not
    		insert_mode = true,
    		min_match_len = 1,
    		max_match_len = math.huge,
    		highlight_single_match = true,
	})

	vim.opt.updatetime = 400 -- ms
end


return module

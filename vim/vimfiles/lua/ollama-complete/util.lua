local vim = vim
local Job = require('plenary.job')

Utils = {}

function Utils.debugPrint(Parent, ...)
	if Parent.debug then
		print("|OLLAMA-COMP| ", ...)
	end
end

function Utils.updateCursorInfo()
	local cursorInfo = {}
	cursorInfo.bufnr = vim.api.nvim_get_current_buf()
	cursorInfo.lineNumber = vim.api.nvim_win_get_cursor(0)[1]
	cursorInfo.columnNumber = vim.api.nvim_win_get_cursor(0)[2]
	return cursorInfo
end

function Utils.serverIsReachable(hostname,callback)
	local url = string.format("http://%s", hostname)
	Job:new({
		command = 'curl',
		args = {'-s', '-o', '/dev/null', '-w', '%{http_code}', url},
		on_exit = function(j, return_val)
			local result = table.concat(j:result(), '')
			if return_val == 0 and result == '200' then
				Utils.debugPrint("Server is reachable")
				callback(true)
			else
				print(string.format("Server %s is not reachable: ", hostname),result)
				callback(false)
			end
		end
	}):start()
end

function Utils.getBufferContents(bufnr)
	local lines =vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	return table.concat(lines, "\n")
end


return Utils

-- vim:set noet sts=0 sw=2 ts=2: --


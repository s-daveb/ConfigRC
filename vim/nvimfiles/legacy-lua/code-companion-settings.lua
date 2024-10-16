local M = {}

local vim = vim
local codecompanion = require("codecompanion")
local adapters = require("codecompanion.adapters")
local Job = require("plenary.job")

local env_host = vim.env["OLLAMA_HOST"] or "localhost:11434"
local selected_model = vim.env["OLLAMA_DEFAULT_MODEL"] or "phi3"

local host_url = "http://" .. env_host .. "/api/chat"

local function serverIsReachable(hostname,callback)
	local url = string.format("http://%s", hostname)
	Job:new({
		command = 'curl',
		args = {'-s', '-o', '/dev/null', '-w', '%{http_code}', url},
		on_exit = function(j, return_val)
			local result = table.concat(j:result(), '')
			if return_val == 0 and result == '200' then
				--Utils.debugPrint("Server is reachable")
				callback(true)
			else
				print(string.format("Server %s is not reachable: ", hostname),result)
				callback(false)
			end
		end
	}):start()
end

local ollama_adapter = adapters.use("ollama", {
  url=host_url,
  schema = {
    model = {
      default = selected_model
    },
  },
})

function M.load()
	serverIsReachable(env_host, function(isReachable)
		if (isReachable == false) then
			print("Server is reachable")
			env_host = "localhost:11434"
			host_url = "http://" .. env_host .. "/api/chat"
		end
	end)
	codecompanion.setup({
		strategies = {
  		chat = "ollama",
  		inline = "ollama",
  		tool = "ollama"
		},
  	adapters = {
    	  ollama = ollama_adapter,
  	},
	})
	vim.api.nvim_clear_autocmds({ event = "FileType", pattern = "codecompletion" })
	--vim.api.nvim.
end

return M

-- vim: set ts=2 sts=2 sw=2 noexpandtab :

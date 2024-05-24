local M = {}

local vim = vim 
local codecompanion = require("codecompanion")
local adapters = require("codecompanion.adapters")

local env_host = vim.fn.getenv("OLLAMA_HOST")

if env_host == nil or type(env_host) == "userdata" then
    env_host = "localhost:11434"
else
    env_host = tostring(env_host)
end

local host_url = "http://" .. env_host .. "/api/chat"

print(host_url)
local ollama_adapter = adapters.use("ollama", {
  		url=host_url,
      schema = {
        model = {
          default = "codegemma"
        },
      },
    })

function M.load()
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

end

return M

-- vim: set ts=2 sts=2 sw=2 noexpandtab :

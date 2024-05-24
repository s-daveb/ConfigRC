local M = {}

local vim = vim 
local codecompanion = require("codecompanion")
local adapters = require("codecompanion.adapters")

local env_host = vim.fn.getenv("OLLAMA_HOST")
local host_url = env_host .. "/api/chat" or "http://localhost:11434/api/chat"

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

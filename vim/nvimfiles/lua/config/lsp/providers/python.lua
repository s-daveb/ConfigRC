local M = {}

local lspconfig
local capabilities
local keymapper

local function load_home_venv()
	local uv = vim.loop
	local venv_path = os.getenv("HOME") .. "/.venv/bin"

	-- Check if the directory exists
	local stat = uv.fs_stat(venv_path)
	if stat and stat.type == "directory" then
		vim.env.PATH = venv_path .. ":" .. vim.env.PATH
	end
end

load_home_venv()
local pyls_path = vim.fn.exepath('pylsp')

function M.setup(opts)
	lspconfig = opts.lspconfig
	capabilities = opts.capabilities
	keymapper = opts.keymapper

	if vim.fn.executable(pyls_path) == 1 then
		lspconfig.pylsp.setup {
			cmd = { pyls_path },
			filetypes = { 'python' },
			--filetypes = { 'c', 'cpp', 'c.doxygen', 'cpp.doxygen', 'objc', 'objcpp' },
			on_attach = keymapper.set_keys,
			capabilities = capabilities
		}
	end
end

return M

-- vim:set noet sts=0 sw=2 ts=2:

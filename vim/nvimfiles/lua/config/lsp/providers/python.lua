local M = {}

local lspconfig
local capabilities
local keymapper

local pyls_path = vim.fn.exepath('pylsp')

M.python_search_paths = {}
M.current_opts = {}

if not pyls_path then
	print("install pylsp; and make sure its in your PATH")
end

local root_finder = require("lspconfig.util")
		.root_pattern("pycodestyle.conf", "*.pyworkspace", "pyproject.toml")

local function read_lines(filepath)
  local lines = {}
  local fd = io.open(filepath, "r")
  if not fd then
    return lines
  end
  for line in fd:lines() do
    if line:match("%S") then
      table.insert(lines, line)
    end
  end
  fd:close()
  return lines
end

-- Main function: scan for *.pyworkspace, read them, add to pylsp
function M.read_pyworkspace_files()
	-- Remove duplicate entries from a list of strings
	local function uniq(list)
		local seen = {}
		local out   = {}
		for _, v in ipairs(list) do
			if not seen[v] then
				seen[v] = true
				table.insert(out, v)
			end
		end
		return out
	end

  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then
    return
  end

  local project_root = root_finder(bufname)
  if not project_root or project_root == "" then
    return
  end

  local workspace_files = vim.fn.globpath(project_root, "*.pyworkspace", false, true)
  if vim.tbl_isempty(workspace_files) then
		vim.print("no .pyworkspace files found");
    return
  end

  -- 4) For each .pyworkspace file, read every non-blank line as a path
  for _, ws_file in ipairs(workspace_files) do
    local dirs = read_lines(ws_file)
    for _, dirpath in ipairs(dirs) do
      -- If it’s a relative path, make it absolute relative to project_root
      if not dirpath:match("^/") then
        dirpath = project_root .. "/" .. dirpath
      end

      -- 5) Finally, tell the active LSP client to add this folder
      --    That will make pylsp index it as a workspace folder.
      --    This only works if pylsp is already attached to the buffer.

			vim.print("inserting " .. dirpath)
			table.insert(M.python_search_paths, dirpath)
    end
  end
	M.python_search_paths = uniq(M.python_search_paths);
end


local function update_python_search_paths()
	M.read_pyworkspace_files()
  return {
    pylsp = {
      plugins = {
        rope = {
          python_path = M.python_search_paths,
        },
        jedi = {
          extra_paths = M.python_search_paths,
        },
      },
    },
  }
end

local function configure_pylsp(opts)
	update_python_search_paths()

	if vim.fn.executable(pyls_path) == 1 then
		lspconfig.pylsp.setup {
			cmd = { pyls_path },
			filetypes = { 'python' },
			root_dir = root_finder,
			on_attach = keymapper.set_keys,
			settings = {
				pylsp = {
					plugins = {
						rope_autoimport = {
							enabled = true,
							completions = {
								enabled = true,
							},
							code_actions = {
								enabled = true,
							},
						},
						rope_completion = {
							enabled = true,
							eager = true,
						},
						rope = {
							python_path = vim.deepcopy(M.python_search_paths),
						},
						jedi = {
							prioritize_extra_paths = true,
							extra_paths = vim.deepcopy(M.python_search_paths),
						},
					},
				},
				capabilities = capabilities
			}
		}
	end

end

function M.setup(opts)
	lspconfig = opts.lspconfig
	capabilities = opts.capabilities
	keymapper = opts.keymapper

	M.current_opts = vim.deepcopy(opts);

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "python",
		callback = function()
			local clients = vim.lsp.get_clients()
			for _, client in ipairs(clients) do
				if (client.name == "pylsp") then
					client.stop();
				end

				configure_pylsp(M.current_opts)
				vim.defer_fn(function()
					vim.cmd("LspStart pylsp")
				end, 50)
			end
		end
	})

end
return M

-- vim:set noet sts=0 sw=2 ts=2:

local nvim_lsp = require('lspconfig')

-- Function to configure LSP mappings
local on_attach = function(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    -- Mappings
    buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>b', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>]', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>[', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>hint', '<cmd>ClangdToggleInlayHints<CR>', opts)
    buf_set_keymap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
		buf_set_keymap('n', '<leader>gh', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
		buf_set_keymap('n', '<leader>kf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
		buf_set_keymap('n', '<leader>fix', '', {
    	noremap = true,
    	silent = true,
    	callback = function()
        vim.lsp.buf.code_action({
          context = { only = {"quickfix"} }, apply=true }
        )
    	end
		})
		print("lsp keybinding set")
end

-- Setup LSP server
local clangd_path = vim.fn.exepath('clangd')

if vim.fn.executable(clangd_path) == 1 then
	nvim_lsp.clangd.setup {
		cmd = {
            		clangd_path,
            		'-j=6',
            		'--background-index',
            		'--background-index-priority=background',
            		'--clang-tidy',
            		'--header-insertion=iwyu',
            		'--header-insertion-decorators',
            		'--function-arg-placeholders',
            		'--pch-storage=memory'
        	},
        	filetypes = { 'c', 'cpp', 'c.doxygen', 'cpp.doxygen', 'objc', 'objcpp' },
    	    on_attach = on_attach
	}

end


-- vim:set noet sts=0 sw=2 ts=2:

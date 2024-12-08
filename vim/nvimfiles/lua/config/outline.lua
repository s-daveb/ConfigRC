local M = {}

local custom = {
    -- Add default configuration options if needed
    keymap_toggle = "<C-T>",
    keymap_leader_toggle = "<leader>o",
    lsp_autocmd_enabled = true,
    lsp_filetypes = { "cpp", "cpp.doxygen" },
}

local outline_opts = {
    keymaps = {
        show_help = '?',
        close = {'<Esc>', 'q'},
        -- Jump to symbol under cursor.
        -- It can auto close the outline window when triggered, see
        -- 'auto_close' option above.
        goto_location = '<Cr>',
        -- Jump to symbol under cursor but keep focus on outline window.
        peek_location = 'o',
        -- Visit location in code and close outline immediately
        goto_and_close = '<S-Cr>',
        -- Change cursor position of outline window to match current location in code.
        -- 'Opposite' of goto/peek_location.
        restore_location = '<C-g>',
        -- Open LSP/provider-dependent symbol hover information
        hover_symbol = '<C-space>',
        -- Preview location code of the symbol under cursor
        toggle_preview = 'K',
        rename_symbol = 'r',
        code_actions = 'a',
        -- These fold actions are collapsing tree nodes, not code folding
        fold = 'h',
        unfold = 'l',
        fold_toggle = '<Tab>',
        -- Toggle folds for all nodes.
        -- If at least one node is folded, this action will fold all nodes.
        -- If all nodes are folded, this action will unfold all nodes.
        fold_toggle_all = '<S-Tab>',
        fold_all = 'W',
        unfold_all = 'E',
        fold_reset = 'R',
        -- Move down/up by one line and peek_location immediately.
        -- You can also use outline_window.auto_jump=true to do this for any
        -- j/k/<down>/<up>.
        down_and_jump = '<C-j>',
        up_and_jump = '<C-k>',
    },
}


function M.load()
    -- Setup the outline plugin
    require('outline').setup(outline_opts)

    -- Keymaps for toggling the outline
    vim.keymap.set("n", custom.keymap_toggle, "<cmd>Outline<CR>", { desc = "Toggle Outline" })
    vim.keymap.set("n", custom.keymap_leader_toggle, "<cmd>Outline<CR>", { desc = "Toggle Outline" })

    -- LSP attach autocmd for specific filetypes
    if custom.lsp_autocmd_enabled then
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local buf = args.buf
                local filetype = vim.bo[buf].filetype
                if vim.tbl_contains(custom.lsp_filetypes, filetype) then
                    vim.schedule(function()
                        vim.cmd("Outline!")
                    end)
                end
            end,
            desc = "Open Outline after LSP attaches to a relevant file"
        })
    end
end

return M

-- vim : set sw=4 ts=4 et :

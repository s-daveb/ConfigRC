local module = {}

module.refactoring = require('refactoring')

function module.load()
    -- prompt for a refactor to apply when the remap is triggered
    vim.keymap.set(
        {"n", "x"},
        "<leader>rr",
        function() module.refactoring.select_refactor() end
    )
    -- Note that not all refactor support both normal and visual mode
    vim.keymap.set({ "n", "x" }, "<leader>re",
        function() return module.refactoring.refactor('Extract Function') end,
        { expr = true }
    )
    vim.keymap.set({ "n", "x" }, "<leader>rf",
        function() return module.refactoring.refactor('Extract Function To File') end,
        { expr = true }
    )
    vim.keymap.set({ "n", "x" }, "<leader>rv",
        function() return module.refactoring.refactor('Extract Variable') end,
        { expr = true }
    )
    vim.keymap.set({ "n", "x" }, "<leader>rI",
        function() return module.refactoring.refactor('Inline Function') end,
        { expr = true }
    )
    vim.keymap.set({ "n", "x" }, "<leader>ri",
        function() return module.refactoring.refactor('Inline Variable') end,
        { expr = true }
    )
    vim.keymap.set({ "n", "x" }, "<leader>rbb",
        function() return module.refactoring.refactor('Extract Block') end,
        { expr = true }
    )
    vim.keymap.set({ "n", "x" }, "<leader>rbf",
        function() return module.refactoring.refactor('Extract Block To File') end,
        { expr = true }
    )
end

return module

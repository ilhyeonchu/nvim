-- plugins/trouble.lua
return {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        use_diagnostic_signs = true,
        auto_open = false,
        auto_close = false,
        focus = true,
        modes = {
            diagnostics = { -- 기본: 현재 버퍼 진단
                win = { position = "bottom", size = 12 },
            },
        },
    },
    config = function(_, opts)
        require("trouble").setup(opts)
        -- 빠른 토글/전환 키맵
        vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble: Diagnostics (buf)" })
        vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            { desc = "Trouble: Diagnostics (buf only)" })
        vim.keymap.set("n", "<leader>xw",
            "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.WARN<cr>",
            { desc = "Trouble: Warnings" })
        vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble: Loclist" })
        vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble: Quickfix" })
        vim.keymap.set("n", "gR", "<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
            { desc = "Trouble: LSP references" })
    end,
}

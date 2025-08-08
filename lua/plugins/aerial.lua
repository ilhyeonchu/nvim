-- plugins/aerial.lua
return {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        backends = { "treesitter", "lsp", "markdown" },
        layout = { default_direction = "right", min_width = 28 },
        attach_mode = "global",
        show_guides = true,
        highlight_on_hover = true,
        manage_folds = true, -- zr/zm 등과 연동
        link_tree_to_folds = true,
        link_folds_to_tree = true,
        nerd_font = "auto",
        close_on_select = false,
        filter_kind = false, -- 모두 표시(필요 시 { "Class", "Function" } 등으로 제한)
    },
    config = function(_, opts)
        local aerial = require("aerial")
        require("aerial").setup(opts)

        -- 토글 및 점프 키맵
        vim.keymap.set("n", "<leader>ao", "<cmd>AerialToggle<cr>", { desc = "Aerial: Toggle outline" })
        vim.keymap.set("n", "<leader>aj", "<cmd>AerialNext<cr>", { desc = "Aerial: Next symbol" })
        vim.keymap.set("n", "<leader>ak", "<cmd>AerialPrev<cr>", { desc = "Aerial: Prev symbol" })
        vim.keymap.set("n", "<leader>af", function()
            aerial.open({ focus = true })
        end, { desc = "Aerial: Open & focus" })
        -- 검색으로 이동하기위한 설정
        pcall(function() require("telescope").load_extension("aerial") end)
        vim.keymap.set("n", "<leader>as", "<cmd>Telescope aerial<cr>", { desc = "Aerial: Search symbols" })

        -- LSP 진단/정의 등 내비게이션 시미볼 동기화
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "lua", "python", "cpp", "c", "javascript", "typescript", "rust", "go" },
            callback = function()
                if not require("aerial").is_open() then
                    aerial.open({ focus = false })
                end
            end,
        })

        -- -- 자동 오픈
        -- vim.api,nvim_create_autocmd("LspAttach", {
        --     callback = function ()
        --         if not aerial.is_open() then
        --             aerial.open({ focus = false })
        --         end
        --     end,
        --     desc = "Auto-open Aerial on LspAttach without stealing focus",
        -- })

        -- (옵션) lualine 연동: 현재 심볼 경로 표시
        local ok, lualine = pcall(require, "lualine")
        if ok then
            local aerial = require("aerial")
            lualine.setup({
                sections = {
                    lualine_c = {
                        { "filename" },
                        { aerial.get_location, cond = aerial.is_available },
                    },
                },
            })
        end
    end,
}

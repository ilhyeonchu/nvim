-- plugins/aerial.lua
return {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        backends = { "lsp", "treesitter", "markdown" },
        layout = { default_direction = "right", min_width = 28 },
        attach_mode = "global",
        show_guides = true,
        highlight_on_hover = true,
        manage_folds = true, -- zr/zm 등과 연동
        link_tree_to_folds = false,
        link_folds_to_tree = true,
        nerd_font = "auto",
        filter_kind = false, -- 모두 표시(필요 시 { "Class", "Function" } 등으로 제한)
    },
    config = function(_, opts)
        require("aerial").setup(opts)

        -- 토글 및 점프 키맵
        vim.keymap.set("n", "<leader>ao", function()
            require("aerial").open({ focus = true }) -- 열면서 포커스 이동
        end, { desc = "Aerial: Toggle outline" })
        vim.keymap.set("n", "<leader>aj", "<cmd>AerialNext<cr>", { desc = "Aerial: Next symbol" })
        vim.keymap.set("n", "<leader>ak", "<cmd>AerialPrev<cr>", { desc = "Aerial: Prev symbol" })

        -- 심볼 선택해서 점프 후 아웃라인 닫기
        require("aerial").setup({
            close_on_select = true
        })

        -- 검색으로 이동하기위한 설정
        require("telescope").load_extension("aerial")
        vim.keymap.set("n", "<leader>as", "<cmd>Telescope aerial<cr>", { desc = "Aerial: Search symbols" })

        -- LSP 진단/정의 등 내비게이션 시미볼 동기화
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "lua", "python", "cpp", "c", "javascript", "typescript", "rust", "go" },
            callback = function()
                if not require("aerial").is_open() then
                    -- 필요 시 자동 오픈을 원하면 다음 줄의 주석을 해제
                    -- vim.cmd("AerialOpen")
                end
            end,
        })

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

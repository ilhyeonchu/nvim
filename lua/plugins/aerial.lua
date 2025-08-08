-- plugins/aerial.lua
return {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        -- Treesitter를 우선으로 사용해 로컬 변수/파라미터 등 탐지력 향상
        -- Prefer Treesitter to improve detection of locals/params
        backends = { "treesitter", "lsp", "markdown" },

        layout = { default_direction = "right", min_width = 28 },
        attach_mode = "global",
        show_guides = true,
        highlight_on_hover = true,

        -- Aerial ↔ 코드 폴드 동기화 완전 해제 (폴드는 Treesitter가 담당)
        -- Fully disable Aerial <-> code fold sync (folds handled by Treesitter)
        manage_folds = false,
        link_tree_to_folds = true,
        link_folds_to_tree = true,

        -- 점프 후 아웃라인 유지
        -- Keep outline after jump
        close_on_select = false,

        nerd_font = "auto",
        -- 필요 시 심볼 종류를 제한하려면 아래를 사용
        -- Restrict kinds if needed:
        -- filter_kind = { "Class","Struct","Interface","Function","Method","Field","Property","Variable","Constant","Enum","Module","Namespace","Parameter" },
        filter_kind = false,
    },
    config = function(_, opts)
        local aerial = require("aerial")
        aerial.setup(opts)

        ---------------------------------------------------------------------------
        -- (A안 필수) 폴드는 Treesitter가 관리하도록 전역 설정
        -- (Plan A required) Let Treesitter manage folds globally
        ---------------------------------------------------------------------------
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = true
        vim.opt.foldlevel  = 99 -- 시작 시 대부분 펼친 상태 / mostly open at start

        ---------------------------------------------------------------------------
        -- 키맵: ao=토글(포커스 유지), af=열고 포커스 이동, aj/ak=심볼 이동
        -- Keymaps: ao=toggle(keep focus), af=open & focus, aj/ak=navigate symbols
        ---------------------------------------------------------------------------
        vim.keymap.set("n", "<leader>ao", function()
            if aerial.is_open() then
                aerial.close()
            else
                aerial.open({ focus = false }) -- 포커스는 편집창에 유지 / keep focus in editor
            end
        end, { desc = "Aerial: Toggle (keep focus)" })

        vim.keymap.set("n", "<leader>af", function()
            aerial.open({ focus = true }) -- 아웃라인으로 포커스 이동 / move focus to outline
        end, { desc = "Aerial: Open & focus" })

        vim.keymap.set("n", "<leader>aj", "<cmd>AerialNext<cr>", { desc = "Aerial: Next symbol" })
        vim.keymap.set("n", "<leader>ak", "<cmd>AerialPrev<cr>", { desc = "Aerial: Prev symbol" })

        ---------------------------------------------------------------------------
        -- Telescope 연동: 심볼 검색 후 점프
        -- Telescope integration: search symbols then jump
        ---------------------------------------------------------------------------
        pcall(function() require("telescope").load_extension("aerial") end)
        vim.keymap.set("n", "<leader>as", "<cmd>Telescope aerial<cr>", { desc = "Aerial: Search symbols" })

        ---------------------------------------------------------------------------
        -- 항상 구조를 보도록 자동 오픈(포커스는 훔치지 않음)
        -- Always show outline by auto-open (without stealing focus)
        ---------------------------------------------------------------------------
        local function open_aerial_keep_focus()
            if not aerial.is_open() then
                aerial.open({ focus = false })
            end
        end

        -- LSP가 붙을 때 / on LSP attach
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function() vim.schedule(open_aerial_keep_focus) end,
            desc = "Auto-open Aerial on LspAttach (no focus steal)",
        })

        -- LSP가 없어도 파일 읽을 때 열기 / open on buffer read even without LSP
        vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
            callback = function() vim.defer_fn(open_aerial_keep_focus, 50) end,
            desc = "Auto-open Aerial on buffer read/new (no focus steal)",
        })

        -- 빈 버퍼로 시작하는 경우 커버 / cover empty-start sessions
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function() vim.defer_fn(open_aerial_keep_focus, 100) end,
            desc = "Auto-open Aerial on VimEnter (no focus steal)",
        })

        ---------------------------------------------------------------------------
        -- (옵션) lualine에 현재 심볼 경로 표시
        -- (Optional) show current symbol path in lualine
        ---------------------------------------------------------------------------
        local ok, lualine = pcall(require, "lualine")
        if ok then
            local get_location = aerial.get_location
            local is_available = aerial.is_available
            lualine.setup({
                sections = {
                    lualine_c = {
                        { "filename" },
                        { get_location, cond = is_available },
                    },
                },
            })
        end
    end,
}

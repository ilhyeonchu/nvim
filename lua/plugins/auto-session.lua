-- plugins/auto-session.lua
return {
    "rmagatti/auto-session",
    event = "VimEnter",
    opts = {
        log_level = "error",
        auto_session_suppress_dirs = { "~/" },
        auto_restore_enabled = true,
        auto_save_enabled = true,
        auto_session_use_git_branch = true, -- 프로젝트 브랜치별 세션 분리
        cwd_change_handling = { restore_upcoming_session = true },
    },
    config = function(_, opts)
        require("auto-session").setup(opts)
        -- 세션 제어 키맵
        vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<cr>", { desc = "Save session" })
        vim.keymap.set("n", "<leader>sr", "<cmd>SessionRestore<cr>", { desc = "Restore session" })
        vim.keymap.set("n", "<leader>sd", "<cmd>SessionDelete<cr>", { desc = "Delete session" })
    end,
}

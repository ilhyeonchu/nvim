return {
    "kawre/neotab.nvim",                    -- Tab-out 플러그인
    event = "InsertEnter",
    opts = {
        tabkey = "<Tab>",                   -- 앞으로 탭 아웃
        backwards_tabkey = "<S-Tab>",       -- 뒤로 탭 아웃
        act_as_tab = true,                  -- 아웃할게 없을 시 일반 Tab
        completion = false,                 -- cmp 활성화시에 neotab 비활성
    },
    depedencies = {
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
    },
}

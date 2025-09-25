-- markdown: 마크다운 작성 보조 및 실시간 프리뷰 플러그인 묶음
return {
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("mkdnflow").setup({
        -- 기본 설정만으로 표/목록/링크 보조 기능을 제공
        filetypes = { md = true, markdown = true, rmarkdown = true },
      })
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown", "text" },
    init = function()
      vim.g.table_mode_corner = "|"
      vim.g.table_mode_disable_mappings = 1
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      heading = { enabled = true },
      code = { sign = false },
      latex = { enabled = true },
      link = { enabled = true },
      table = { enabled = true },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      if vim.fn.executable("npm") == 1 then
        vim.fn["mkdp#util#install_sync"]()
      else
        vim.notify("markdown-preview.nvim: npm/node가 없어 설치를 건너뜁니다.", vim.log.levels.WARN)
      end
    end,
    init = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}

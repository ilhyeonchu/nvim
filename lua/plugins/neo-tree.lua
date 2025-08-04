-- neo-tree: 파일 탐색기, git 상태, 버퍼 목록 등을 보여주는 사이드바 플러그인
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "left",
        width = 30,
      },
    })
  end,
--  init = function()
--    vim.api.nvim_create_autocmd("VimEnter", {
--      group = vim.api.nvim_create_augroup("neotree_on_startup", { clear = true }),
--      callback = function()
--        vim.cmd("Neotree")
--      end,
--    })
--  end,
}

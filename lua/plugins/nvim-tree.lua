return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  -- 키 매핑은 keymaps.lua에서 관리
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
  end,
}

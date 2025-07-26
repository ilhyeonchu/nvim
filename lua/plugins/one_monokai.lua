-- one_monokai: Monokai 테마를 Neovim에 적용하는 플러그인
return {
    "cpea2506/one_monokai.nvim",
    dependencies = {
      "nvim-lualine/lualine.nvim",
    },
    priority = 1000,
    config = function()
      require("lualine").setup {
        options = {
            theme = "one_monokai"
        }
      }

      vim.cmd [[colorscheme one_monokai]]
    end,
    options = {
      transparent = true,
      italics = true,
    },
}
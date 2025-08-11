-- one_monokai: Monokai 테마를 Neovim에 적용하는 플러그인
return {
    "cpea2506/one_monokai.nvim",
    dependencies = {},
    priority = 1000,
    config = function()
      -- colorscheme만 적용. lualine 테마는 중앙 설정에서 지정
      vim.cmd [[colorscheme one_monokai]]
    end,
    options = {
      transparent = true,
      italics = true,
    },
}

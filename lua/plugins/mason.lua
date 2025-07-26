-- mason: LSP 서버, 포맷터, 린터 등을 쉽게 설치하고 관리하는 플러그인
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "clangd", "pyright", "texlab", "ocamllsp" },
      automatic_installation = true,
    })
  end,
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("lsp.common").capabilities
    local on_attach = require("lsp.common").on_attach

    local servers = require("mason-lspconfig").get_installed_servers()

    for _, server_name in ipairs(servers) do
      local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }
      -- 각 서버별 커스텀 설정이 있다면 여기서 적용할 수 있습니다.
      -- 예: if server_name == "lualsp" then ... end
      require("lspconfig")[server_name].setup(opts)
    end
  end,
}

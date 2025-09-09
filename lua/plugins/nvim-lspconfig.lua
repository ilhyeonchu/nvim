-- nvim-lspconfig: Neovim의 내장 LSP 클라이언트를 설정하는 플러그인
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
      -- jdtls(Java)는 전용 플러그인(nvim-jdtls)으로 ftplugin에서 구동하므로 여기선 스킵
      if server_name ~= "jdtls" then
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        -- 서버별 미세 조정 가능
        -- if server_name == "tsserver" then
        --   opts.on_attach = function(client, bufnr)
        --     -- 포맷 충돌을 줄이고 싶다면 tsserver 포맷 비활성화
        --     client.server_capabilities.documentFormattingProvider = false
        --     on_attach(client, bufnr)
        --   end
        -- end
        require("lspconfig")[server_name].setup(opts)
      end
    end
  end,
}

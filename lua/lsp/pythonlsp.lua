local common = require('lsp.common')

require('lspconfig').pyright.setup {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
  }
}


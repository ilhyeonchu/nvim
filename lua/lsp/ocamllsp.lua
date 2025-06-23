local common = require('lsp.common')

require('lspconfig').ocamllsp.setup {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
}

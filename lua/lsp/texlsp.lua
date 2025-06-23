local common = require('lsp.common')

require('lspconfig').texlab.setup {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
}

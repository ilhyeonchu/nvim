local common = require('lsp.common')

require('lspconfig').ccls.setup {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "cc"},
}

local M = {}

-- LSP 설정에 공통으로 적용할 on_attach 함수
M.on_attach = function(client, bufnr)
  -- 키 매핑 설정
  local opts = { noremap = true, silent = true, buffer = bufnr }
  
  -- 일반적인 LSP 키 매핑
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  -- LSP 네임스페이스(<leader>l...)로 정리하여 사용자 키맵 충돌 방지
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>ll', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts)

  -- Inlay hints 자동 활성화 (Neovim 0.9/0.10 호환)
  local ih = vim.lsp.inlay_hint
  local ok = ih ~= nil
  if ok then
    if type(ih) == "function" then
      pcall(ih, bufnr, true)
    elseif type(ih) == "table" and type(ih.enable) == "function" then
      pcall(ih.enable, true, { bufnr = bufnr })
    end
  end
end

-- LSP capabilities 향상
M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M

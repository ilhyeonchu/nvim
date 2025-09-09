-- Native filetype overrides (replace legacy filetype.nvim)

-- Prefer Neovim's builtin filetype detection and add overrides.
-- Compatible with both 0.7+ (vim.filetype.add) and fallback for older.

local has_add = vim.filetype and type(vim.filetype.add) == "function"

if has_add then
  -- Neovim 0.7+ canonical API
  vim.filetype.add({
    extension = {
      tl = "teal",
    },
    filename = {
      Jenkinsfile = "groovy",
    },
    pattern = {
      [".*%.env%..+"] = "sh",
    },
  })
else
  -- Fallback: simple autocmd-based detection (older versions only)
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.tl",
    command = "setfiletype teal",
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "Jenkinsfile",
    command = "setfiletype groovy",
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = ".*.env.*",
    command = "setfiletype sh",
  })
end

-- Makefile: 탭 문자 필수. 기본 탭 폭은 8, 스페이스 확장 금지.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 0
  end,
})

-- C/C++/ObjC/CUDA: Google 스타일(2 스페이스)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Go: 탭 사용(go fmt 규칙), 표시 폭 8 (관습)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 0
  end,
})

-- Java/C#: 4 스페이스 관용
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java", "cs" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- CMake: 2 스페이스 관용
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cmake" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

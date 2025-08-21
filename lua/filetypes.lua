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


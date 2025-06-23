-- 리더키 설정
vim.g.mapleader = ' '

-- Set the package manager of NeoVim to lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install NeoVim Plugins
require("lazy").setup("plugins", {})

-- Set-up the basic configurations
require("options")
require("keymaps")

-- Set-up language clients
require("lsp.ocamllsp")
require("lsp.lualsp")
require("lsp.texlsp")
require("lsp.cclslsp")
require("lsp.pythonlsp")

-- Install NeoVim Plugins
-- require("lazy").setup("plugins", {})

require("lualine").setup({
  sections = {
    lualine_x = {
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      }
    },
  },
})

-- Neovim 전역 옵션 설정 (PEP 8 스타일 주석)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.bo.softtabstop = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = false

-- C,C++,Go,Java 등 C 계열 파일만 smartindent 활성화
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"c", "cpp", "java", "go"},
    callback = function()
        vim.bo.smartindent = true
        vim.opt_local.formatoptions:remove({ "c", "r", "o"})
    end,
})
-- 파이썬 등 smartindent 비활성화
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"python", "lua", "julia"},
    callback = function()
        vim.bo.smartindent = false
        vim.opt_local.formatoptions:remove({"c", "r", "o"})
    end,
})

-- 줄 번호 표시 등 추가 옵션 (init_numbering.lua 참고)
vim.wo.number = true
-- vim.wo.relativenumber = true
vim.opt.scrolloff = 5


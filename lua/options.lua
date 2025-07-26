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

-- tmux 설정
if os.getenv("TMUX") then
    vim.g.clipboard = {
        name = 'tmux',
        copy = {
            ['+'] = 'tmux load-buffer -',
            ['*'] = 'tmux load-buffer -',
        },
        paste = {
            ['+'] = 'tmux save-buffer -',
            ['*'] = 'tmux save-buffer -',
        },
        cache_enabled = 1,
    }
end



-- 배경 투명화 설정
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
  end,
})

-- 주석 색상 변경
-- 하이라이트 오버라이드를 위한 autocmd 그룹 생성
local highlight_group = vim.api.nvim_create_augroup("CustomHighlightOverrides", { clear = true })

-- ColorScheme 이벤트 발생 시 실행될 autocmd 생성
vim.api.nvim_create_autocmd("ColorScheme", {
    group = highlight_group,
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "Comment", { fg = "#8a81a3", italic = true })
    end,
})

-- 초기 로드 시에도 한 번 실행
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })

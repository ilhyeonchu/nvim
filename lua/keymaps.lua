-- 키 매핑 전용 파일

--[[
  플러그인 키 매핑 모음
  - 각 플러그인별로 섹션을 나누고 설명을 추가
  - 중복된 키 매핑이 있는 경우 주의
--]]

-- ===== neo-tree =====
vim.keymap.set('n', '<leader>fo', '<Cmd>Neotree toggle<CR>', { noremap = true, silent = true, desc = 'Neotree: 토글' })

-- ===== harpoon =====
local harpoon = require('harpoon')
harpoon:setup()
vim.keymap.set('n', '<leader>aa', function() harpoon:list():add() end, { desc = 'Harpoon: 파일 추가' })
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: 퀵 메뉴' })
vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end, { desc = 'Harpoon: 1번 파일로 이동' })
vim.keymap.set('n', '<C-t>', function() harpoon:list():select(2) end, { desc = 'Harpoon: 2번 파일로 이동' })
vim.keymap.set('n', '<C-n>', function() harpoon:list():select(3) end, { desc = 'Harpoon: 3번 파일로 이동' })
vim.keymap.set('n', '<C-s>', function() harpoon:list():select(4) end, { desc = 'Harpoon: 4번 파일로 이동' })
vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end, { desc = 'Harpoon: 이전 파일' })
vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end, { desc = 'Harpoon: 다음 파일' })

-- ===== toggleterm =====
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-\\>', ':ToggleTerm<CR>', { noremap = true, silent = true })

-- ===== bookmarks =====
local bm = require('bookmarks')
local function setup_bookmarks()
    bm.setup {
        save_file = vim.fn.expand("$HOME/.bookmarks"),
        keywords = {
            ["@t"] = "☑️ ", -- Todo
            ["@w"] = "⚠️ ", -- Warn
            ["@f"] = "⛏ ", -- Fix
            ["@n"] = " ", -- Note
        },
    }
end

setup_bookmarks()

vim.keymap.set('n', 'mm', bm.bookmark_toggle, { desc = 'Bookmark: 토글' })
vim.keymap.set('n', 'mi', bm.bookmark_ann, { desc = 'Bookmark: 주석 추가/편집' })
vim.keymap.set('n', 'mc', bm.bookmark_clean, { desc = 'Bookmark: 모두 지우기' })
vim.keymap.set('n', 'mn', bm.bookmark_next, { desc = 'Bookmark: 다음 북마크' })
vim.keymap.set('n', 'mp', bm.bookmark_prev, { desc = 'Bookmark: 이전 북마크' })
vim.keymap.set('n', 'ml', bm.bookmark_list, { desc = 'Bookmark: 목록 보기' })

-- ===== telescope =====
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope: 파일 찾기' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: 텍스트 검색' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: 버퍼 목록' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: 도움말 태그' })

-- ===== 기타 유용한 단축키 =====
-- 예시: vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = '파일 저장' })

-- 검색 후 하이라이트 제거
vim.keymap.set('n', '<Esc>', '<Esc>:nohlsearch<CR>', { noremap = true, silent = true, desc = '검색 하이라이트 제거' })

-- 모든 파일 저장 및 종료 / 모든 파일 저장
vim.keymap.set('n', '<leader>wqa', '<cmd>wqa<CR>', { noremap = true, silent = true, desc = '모든 파일 저장 및 종료' })
vim.keymap.set('n', '<leader>wa', '<cmd>wa<CR>', { noremap = true, silent = true, desc = '모든 파일 저장' })

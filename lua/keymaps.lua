-- 키 매핑 전용 파일

--[[
  플러그인 키 매핑 모음
  - 각 플러그인별로 섹션을 나누고 설명을 추가
  - 중복된 키 매핑이 있는 경우 주의
--]]

-- ===== neo-tree =====
vim.keymap.set(
	"n",
	"<leader>fo",
	"<Cmd>Neotree toggle right<CR>",
	{ noremap = true, silent = true, desc = "Neotree: 토글(오른쪽)" }
)
vim.keymap.set(
	"n",
	"<leader>ff",
	"<Cmd>Neotree focus right<CR>",
	{ noremap = true, silent = true, desc = "Neotree: 포커스(오른쪽)" }
)

-- ===== aerial =====
vim.keymap.set("n", "<leader>ao", "<cmd>AerialToggle<cr>", { desc = "Aerial: Toggle outline" })
vim.keymap.set("n", "<leader>aj", "<cmd>AerialNext<cr>", { desc = "Aerial: Next symbol" })
vim.keymap.set("n", "<leader>ak", "<cmd>AerialPrev<cr>", { desc = "Aerial: Prev symbol" })
vim.keymap.set("n", "<leader>af", function()
	local ok, aerial = pcall(require, "aerial")
	if ok then
		aerial.open({ focus = true })
	else
		vim.cmd("AerialOpen")
	end
end, { desc = "Aerial: Open & focus" })
vim.keymap.set("n", "<leader>as", "<cmd>Telescope aerial<cr>", { desc = "Aerial: Search symbols" })

-- 플러그인 초기화는 lua/plugins/harpoon.lua에서 수행
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>aa", function()
	harpoon:list():add()
end, { desc = "Harpoon: 파일 추가" })
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: 퀵 메뉴" })
vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end, { desc = "Harpoon: 1번 파일로 이동" })
vim.keymap.set("n", "<C-t>", function()
	harpoon:list():select(2)
end, { desc = "Harpoon: 2번 파일로 이동" })
vim.keymap.set("n", "<C-n>", function()
	harpoon:list():select(3)
end, { desc = "Harpoon: 3번 파일로 이동" })
vim.keymap.set("n", "<C-s>", function()
	harpoon:list():select(4)
end, { desc = "Harpoon: 4번 파일로 이동" })
vim.keymap.set("n", "<C-S-P>", function()
	harpoon:list():prev()
end, { desc = "Harpoon: 이전 파일" })
vim.keymap.set("n", "<C-S-N>", function()
	harpoon:list():next()
end, { desc = "Harpoon: 다음 파일" })

-- ===== buffer(tab) 이동 시 사이드바(neo-tree/aerial) 보존 =====
-- 사이드바에 포커스가 있어도 메인 코드 창의 버퍼만 변경되도록 래퍼 함수
local function find_main_window()
	local wins = vim.api.nvim_tabpage_list_wins(0)
	for _, win in ipairs(wins) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.bo[buf].filetype
		if ft ~= "neo-tree" and ft ~= "aerial" and ft ~= "qf" and ft ~= "Trouble" then
			return win
		end
	end
	return vim.api.nvim_get_current_win()
end

local function goto_buffer(num)
	local cur_win = vim.api.nvim_get_current_win()
	local target_win = find_main_window()
	-- 대상 창에서 버퍼 이동 실행
	vim.api.nvim_set_current_win(target_win)
	vim.cmd("BufferGoto " .. num)
	-- 포커스가 사이드바였다면 포커스 복원
	local cur_buf = vim.api.nvim_win_get_buf(cur_win)
	local cur_ft = vim.bo[cur_buf].filetype
	if (cur_ft == "neo-tree" or cur_ft == "aerial") and cur_win ~= target_win then
		vim.api.nvim_set_current_win(cur_win)
	end
end

-- Alt+숫자 키: 항상 메인 창의 버퍼만 변경
for i = 1, 9 do
	vim.keymap.set("n", "<A-" .. i .. ">", function()
		goto_buffer(i)
	end, { desc = "버퍼로 이동 " .. i })
end
vim.keymap.set("n", "<A-0>", function()
	goto_buffer(0)
end, { desc = "마지막 버퍼로 이동" })

-- ===== toggleterm =====
vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-\\>", ":ToggleTerm<CR>", { noremap = true, silent = true })

-- 플러그인 초기화는 lua/plugins/bookmarks.lua에서 수행
local bm = require("bookmarks")

vim.keymap.set("n", "mm", bm.bookmark_toggle, { desc = "Bookmark: 토글" })
vim.keymap.set("n", "mi", bm.bookmark_ann, { desc = "Bookmark: 주석 추가/편집" })
vim.keymap.set("n", "mc", bm.bookmark_clean, { desc = "Bookmark: 모두 지우기" })
vim.keymap.set("n", "mn", bm.bookmark_next, { desc = "Bookmark: 다음 북마크" })
vim.keymap.set("n", "mp", bm.bookmark_prev, { desc = "Bookmark: 이전 북마크" })
vim.keymap.set("n", "ml", bm.bookmark_list, { desc = "Bookmark: 목록 보기" })

-- ===== telescope =====
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fs", builtin.find_files, { desc = "Telescope: 파일 찾기" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: 텍스트 검색" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: 버퍼 목록" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: 도움말 태그" })

-- ===== 기타 유용한 단축키 =====
-- 예시: vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = '파일 저장' })

-- 검색 후 하이라이트 제거
vim.keymap.set(
	"n",
	"<Esc>",
	"<Esc>:nohlsearch<CR>",
	{ noremap = true, silent = true, desc = "검색 하이라이트 제거" }
)

-- 모든 파일 저장 및 종료 / 모든 파일 저장
vim.keymap.set(
	"n",
	"<leader>wqa",
	"<cmd>wqa<CR>",
	{ noremap = true, silent = true, desc = "모든 파일 저장 및 종료" }
)
vim.keymap.set("n", "<leader>wa", "<cmd>wa<CR>", { noremap = true, silent = true, desc = "모든 파일 저장" })
vim.keymap.set(
	"n",
	"<leader>qq",
	"<cmd>qa!<CR>",
	{ noremap = true, silent = true, desc = "모든 파일 강제 종료" }
)

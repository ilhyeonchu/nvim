return {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
  -- or branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- 키 매핑은 keymaps.lua에서 관리
  lazy = false,
  config = function()
    require('telescope').load_extension('bookmarks')
  end
}

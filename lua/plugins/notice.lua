return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["im.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    cmdline = {
            enabled = true, -- 명령줄 UI (:/ 등)
          },
        messages = {
            enabled = true, -- 메시지 패널 (에코 메시지 등)
          },
        popupmenu = {
            enabled = true, -- 자동완성 메뉴 UI
          },
        -- optional: UI 패닉 방지 기본값
        presets = {
          command_palette = true, -- 명령줄과 검색창 통합 
          lsp_doc_border = true, -- 문서 창 테두리
        },
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
}

-- docker-compose LSP 설정
return function()
  -- docker compose 파일에만 제한된 언어 서버 활용
  local compose_files = {
    "docker-compose.yml",
    "docker-compose.yaml",
    "compose.yaml",
    "compose.yml",
  }

  return {
    filetypes = { "yaml" },
    root_dir = function(fname)
      local util = require("lspconfig.util")
      local unpack_fn = table.unpack or unpack
      local detect = util.root_pattern(unpack_fn(compose_files))
      local root = detect(fname)
      return root or util.find_git_ancestor(fname)
    end,
  }
end

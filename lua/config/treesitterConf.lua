local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup({
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  ensure_installed = {
      "swift",
      "tsx",
      "cpp",
      "lua",
      "bash",
      "scss",
      "graphql",
      "javascript",
      "typescript",
      "ruby",
      "python",
  },
  incremental_selection = {
      enable = true,
      keymaps = {
          init_selection = "<M-space>",
          node_incremental = "<M-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
      },
  },
  textobjects = {
      select = {
          enable = true,
          lookahead = true,
      },
      move = {
          enable = true,
          set_jumps = true,
      },
  },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

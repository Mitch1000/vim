return {
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true },
  ensure_installed = {
      "swift",
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
}

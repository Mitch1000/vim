return {
  'folke/neodev.nvim',
  'folke/which-key.nvim',
  { 'folke/neoconf.nvim', cmd = 'Neoconf' },
  -- General plugins
  { 'vim-ruby/vim-ruby' },
  { 'tpope/vim-rails' },
  { 'tpope/vim-fugitive' },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'wellle/context.vim' },
  { 'Shatur/neovim-ayu' },
  { 'mitch1000/backpack' },
  { 'neovim/nvim-lspconfig' },
  { 'mhinz/vim-signify' },
  { 'pangloss/vim-javascript' },
  { 'darfink/vim-plist' },
  { 'Raimondi/delimitMate' },
  { 'joshdick/onedark.vim' },
  { 'lunacookies/vim-colors-xcode' },
  { 'romgrk/barbar.nvim' },
  { 'preservim/nerdcommenter' },
  { 'nvim-tree/nvim-web-devicons' },

  -- Plugins with configuration
  {
    'jackguo380/vim-lsp-cxx-highlight',
      highlight = { lsRanges = true }
  },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
    end
  },

  {
    "nvimdev/guard.nvim",
    dependencies = { 'nvimdev/guard-collection' },
    event = "BufReadPre",
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      -- Add your lualine config here if needed
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "mitch1000/backpack",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Add your neo-tree config here if needed
    end
  },

  -- CoC needs special handling in Lazy
  {
    'neoclide/coc.nvim',
    branch = 'release',
    build = 'yarn install --frozen-lockfile',
    init = function()
      -- CoC specific initialization if needed
    end
  }
}

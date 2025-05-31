local vim = vim

return {
  'folke/neodev.nvim',
  'neoclide/vim-jsx-improve',
  'folke/which-key.nvim',
  { 'folke/neoconf.nvim', cmd = 'Neoconf' },

  -- General plugins
  { 'vim-ruby/vim-ruby' },
  { 'tpope/vim-rails' },
  { 'tpope/vim-fugitive' },
  { 'wellle/context.vim' },
  { 'Shatur/neovim-ayu' },
  { 'neovim/nvim-lspconfig' },
  { 'mhinz/vim-signify' },
  { 'pangloss/vim-javascript' },
  { 'darfink/vim-plist' },
  { 'Raimondi/delimitMate' },
  { 'joshdick/onedark.vim' },
  { 'lunacookies/vim-colors-xcode' },
  {
    'romgrk/barbar.nvim',
    config = function ()
      local barbarConf = require("config.barbarConf")
      

      require('barbar').setup(barbarConf)
    end
  },

  { 'preservim/nerdcommenter' },

  -- Color Schemes
  { 'Abstract-IDE/Abstract-cs' },
  { 'nanotech/jellybeans.vim' },
  { 'sjl/badwolf' },
  { 'jacoborus/tender.vim' },
  { 'tomasiser/vim-code-dark' },
  { 'everviolet/nvim' },
  { 'rktjmp/lush.nvim' },
  { 'ntk148v/habamax.nvim' },
  { 'ayu-theme/ayu-vim' },
  { 'w0ng/vim-hybrid' },
  { 'shaunsingh/nord.nvim' },
  { 'rose-pine/neovim' },
  { 'ficcdaf/ashen.nvim' },
  { 'sainnhe/everforest' },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
    end
  },
  {
    'mitch1000/backpack',
    config = function ()
      vim.g.italicize_comments = 1
      vim.g.backpack_italic = 1
      vim.g.backpack_contrast_dark = "medium" -- soft hard medium
    end
  },

  -- Plugins with configuration
  --
  { 'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
  { 'nvim-treesitter/nvim-treesitter',
    config = function()
      require("nvim-treesitter.configs").setup({
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
      })
    end
  },
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      local configobject = require('config.devicons')
      require('nvim-web-devicons').setup(configobject)
    end
  },

  {
    'jackguo380/vim-lsp-cxx-highlight',
      highlight = { lsRanges = true }
  },
  {
    "nvimdev/guard.nvim",
    dependencies = { 'nvimdev/guard-collection' },
    event = "BufReadPre",
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      "mitch1000/backpack",
    },
    config = function()
    local configobject = require("config.lualine")
    require('lualine').setup(configobject)
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

    transparent = false,
    filesystem = {
      window = {
        mappings = {
          ["/"] = "noop",
          ["u"] = "navigate_up",
        }
      },
      bind_to_cwd = true,
      hijack_netrw_behavior = "disabled",
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
     },
    },
    default_component_configs = {
       name = {
          use_git_status_colors = false
       },
       git_status = {
         symbols = {
         -- Status type
         untracked = "-",
       }
     },
    },
  },

  -- CoC needs special handling in Lazy
  {
    'neoclide/coc.nvim',
    branch = 'release',
    build = 'yarn install --frozen-lockfile',
    init = function()
      require('config.cocconfig')
      -- CoC specific initialization if needed
    end
  },

  {
    'sainnhe/sonokai',
    lazy = false,
    config = function()
      vim.g.sonokai_style = 'default'
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.sonokai_enable_italic = true
    end
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = {
      "mitch1000/backpack",
    },
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},


    config = function()
      local highlight = {
        "Indent",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "Indent", { fg = "#303030" })
      end)


      require("ibl").setup({
       -- scope = { highlight = { 'RainbowRed', } },
       indent = { char = "▏", highlight = highlight },
      })
    end
  },
}

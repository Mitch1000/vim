local vim = vim

return {
  'folke/neodev.nvim',
  'neoclide/vim-jsx-improve',
  'folke/which-key.nvim',
  'andymass/vim-matchup',
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
  { 'romgrk/barbar.nvim' },
  { 'preservim/nerdcommenter' },

  -- Plugins with configuration
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
      local ruby_icon_object = {
         icon = "",
         color = "#db507e",
         cterm_color = "168",
         name = "Rb"
      }
      
      local git_icon_object = { icon = "", color = "#af5f5f", cterm_color = "160", name = "GitLogo" }
      require('nvim-web-devicons').setup({
        override_by_extension = {
          ["js"] = { icon = "", color = "#fbfb04", cterm_color = "58",  name = "Js" }
        },
        override_by_filename = {
         [".git-blame-ignore-revs"] = git_icon_object,
         [".gitattributes"] = git_icon_object,
         [".gitignore"] = git_icon_object,
         [".mailmap"] = git_icon_object,
         ["Gemfile"] = ruby_icon_object,
         ["Rakefile"] = ruby_icon_object,
         ["config.ru"] = ruby_icon_object
        },
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          },
          md = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          },
          rb = ruby_icon_object,
          git = {
            icon = "",
            color = "#87ffaf",
            cterm_color = "121",
            name = "GitLogo"
          }
        };
      })
    end
  },

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
      require('lualine').setup({
        refresh = {
           statusline = 100,
           tabline = 100,
           winbar = 100,
        },
        options = {
           tabline = {
               lualine_z = {
                   {
                       "tabs",
                       cond = function()
                           return #vim.fn.gettabinfo() > 1
                       end,
                   }
               }
           }
        },
      })
      -- Add your lualine config here if needed
      --
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
  },

  {
    'mitch1000/backpack',
    config = function ()
      vim.g.italicize_comments = 1
      vim.g.backpack_italic = 1
      vim.g.backpack_contrast_dark = "medium" -- soft hard medium
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
}

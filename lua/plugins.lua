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
      require('barbar').setup({
        -- Enable/disable animations
        --
        animation = true,
        -- Automatically hide the tabline when there are this many buffers left.
        -- Set to any value >=0 to enable.
        auto_hide = false,
        -- Enable/disable current/total tabpages indicator (top right corner)
        -- Enables/disable clickable tabs
        --  - left-click: go to buffer
        --  - middle-click: delete buffer
        clickable = true,
        -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
        -- Valid options are 'left' (the default), 'previous', and 'right'
        focus_on_close = 'left',
				highlight_alternate = false,
        -- Disable highlighting file icons in inactive buffers
        highlight_inactive_file_icons = false,
        highlight_alternate_file_icons = false,
        -- Enable highlighting visible buffers
        highlight_visible = true,
      
        icons = {
          -- Configure the base icons on the bufferline.
          -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
          buffer_index = false,
          buffer_number = false,
          button = '',
          -- Enables / disables diagnostic symbols
          -- diagnostics = {
          --   [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
          --   [vim.diagnostic.severity.WARN] = {enabled = false},
          --   [vim.diagnostic.severity.INFO] = {enabled = false},
          --   [vim.diagnostic.severity.HINT] = {enabled = true},
          -- },
          -- gitsigns = {
          --   added = {enabled = true, icon = '+'},
          --   changed = {enabled = true, icon = '~'},
          --   deleted = {enabled = true, icon = '-'},
          -- },
          filetype = {
            -- Sets the icon's highlight group.
            -- If false, will use nvim-web-devicons colors
            custom_colors = false,
      
            -- Requires `nvim-web-devicons` if `true`
            enabled = true,
          },
          -- If true, add an additional separator at the end of the buffer list
          separator_at_end = false,
          -- Configure the icons on the bufferline when modified or pinned.
          -- Supports all the base icon options.
          modified = {button = '●'},
          -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
          preset = 'default',
          -- Configure the icons on the bufferline based on the visibility of a buffer.
          -- Supports all the base icon options, plus `modified` and `pinned`.
          alternate = { filetype = { enabled = false } },
          current = { buffer_index = false },
					inactive = {
            separator = { left = '', right = ' ' },
            filetype = { enabled = false }
          },
					pinned = {button = ''},
					separator = {left = '', right = ' '},

          visible = {modified = {buffer_number = false}},
        },
        -- If true, new buffers will be inserted at the start/end of the list.
        -- Default is to insert after current buffer.
        insert_at_end = false,
        insert_at_start = false,
        -- Sets the maximum padding width with which to surround each tab
 				maximum_padding = 2,
        -- Sets the minimum padding width with which to surround each tab
        minimum_padding = 1,
        -- Sets the maximum buffer name length.
        maximum_length = 30,
        -- Sets the minimum buffer name length.
        minimum_length = 0,
        -- If set, the letters for each buffer in buffer-pick mode will be
        -- assigned based on their name. Otherwise or in case all letters are
        -- already assigned, the behavior is to assign letters in order of
        -- usability (see order below)
        semantic_letters = true,
        -- Set the filetypes which barbar will offset itself for
        sidebar_filetypes = {
          -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
          NvimTree = true,
          -- Or, specify the text used for the offset:
          undotree = {
            text = 'undotree',
            align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
          },
          -- Or, specify the event which the sidebar executes when leaving:
          ['neo-tree'] = {event = 'BufWipeout'},
          -- Or, specify all three
          Outline = {event = 'BufWinLeave', text = 'symbols-outline', align = 'right'},
        },
        -- New buffer letters are assigned in this order. This order is
        -- optimal for the qwerty keyboard layout but might need adjustment
        -- for other layouts.
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
        -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
        -- where X is the buffer number. But only a static string is accepted here.
        no_name_title = nil,
        -- sorting options
        sort = {
          -- tells barbar to ignore case differences while sorting buffers
          ignore_case = true,
        },
      })
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
}

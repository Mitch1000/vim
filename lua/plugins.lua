local vim = vim

return {
  'folke/neodev.nvim',
  'neoclide/vim-jsx-improve',
  'folke/which-key.nvim',
  { 'folke/neoconf.nvim', cmd = 'Neoconf' },

  -- General plugins
  { 'neovim/nvim-lspconfig' },
  { 'vim-ruby/vim-ruby' },
  { 'tpope/vim-rails' },
  { 'tpope/vim-fugitive' },
  { 'wellle/context.vim' },
  { 'pangloss/vim-javascript' },
  { 'darfink/vim-plist' },
  { 'Raimondi/delimitMate' },
  { 'ful1e5/onedark.nvim' },
  { 'ellisonleao/gruvbox.nvim' },
  { 'lunacookies/vim-colors-xcode' },
  { 'kevinhwang91/promise-async' },
  { 'preservim/nerdcommenter' },
  { 'Yggdroot/indentLine' },
  { 'rktjmp/lush.nvim' },
  { 'Mofiqul/vscode.nvim' },
  { 'cocopon/iceberg.vim' },
  { 'binhtran432k/dracula.nvim' },

  -- Color Schemes
  { 'Shatur/neovim-ayu' },
  { 'Everblush/nvim', name = 'everblush' },
  { 'Abstract-IDE/Abstract-cs' },
  { 'nanotech/jellybeans.vim' },
  { 'sjl/badwolf' },
  { 'jacoborus/tender.vim' },
  { 'tomasiser/vim-code-dark' },
  { 'everviolet/nvim' },
  { 'ntk148v/habamax.nvim' },
  { 'ayu-theme/ayu-vim' },
  { 'w0ng/vim-hybrid' },
  { 'shaunsingh/nord.nvim' },
  { 'rose-pine/neovim' },
  { 'ficcdaf/ashen.nvim' },
  { 'EdenEast/nightfox.nvim' },
  { 'sainnhe/everforest' },

  {
    'mitch1000/backpack.nvim',
    config = function ()
      require('backpack').setup({
        transparent = true,
        tabSigns = true,
        colors = { palette = { background = "#1e1e1e" }},
        -- colors = { palette = { background = "#ffffff" }},
        theme = "dark",
      })
    end
  },

  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
    end
  },

  --------- Plugins ---------------------------------------------------------------------------------
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    config = function ()
      --
      -- vim.cmd([[hi! link BufferCurrent Normal]])
      -- vim.cmd([[hi! link BufferCurrentSign Normal]])
      -- vim.cmd([[hi! link BufferCurrentTarget Normal]])
      -- vim.cmd([[hi! link BufferCurrentMod Normal]])
      -- vim.cmd([[hi! link BufferCurrentIcon Normal]])
      --
      if vim.g.my_color_scheme == "backpack" then
        local barbarConf = require("config.barbarConf")
        Barbar = require('barbar')

        Barbar.setup(barbarConf)
      end 
    end
  },
  -- Plugins with configuration
  { 'nvim-treesitter/nvim-treesitter',
    config = function()
      require("config.treesitterConf")
    end
  },

  { 'mitch1000/anchorage.nvim' },

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
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
    local configobject = require("config.lualine")
    require('lualine').setup(configobject)
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
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
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function ()
        local function dump(o)
           if type(o) == 'table' then
              local s = '{ '
              for k,v in pairs(o) do
                 if type(k) ~= 'number' then k = '"'..k..'"' end
                 s = s .. '['..k..'] = ' .. dump(v) .. ','
              end
              return s .. '} '
           else
              return tostring(o)
           end
        end

      local handler = function(virtText, lnum, endLnum, width, truncate)
          -- local InsertMarker = require("helpers.insert_marker")
          -- local marker = " "
          -- local lineNumber = vim.fn.line('.')
          -- print(lineNumber)
          -- local indent = vim.fn.indent(lineNumber)
          -- local tabstop = vim.o.tabstop

          -- InsertMarker(lineNumber - 1, marker, 0, 'inline')
          -- InsertMarker(lineNumber - 1, "  ", 0, 'inline')
          -- local folded_lines = vim.g.folded_lines

          -- table.insert(folded_lines, vim.fn.line("."))

            -- print("close", vim.g.folded_lines[0])
            -- vim.g.folded_lines = folded_lines

          -- MF()
          local newVirtText = {}
          local suffix = (' 󰁂 %d '):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
              local chunkText = chunk[1]
              local chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if targetWidth > curWidth + chunkWidth then
                  table.insert(newVirtText, chunk)
              else
                  chunkText = truncate(chunkText, targetWidth - curWidth)
                  local hlGroup = chunk[2]
                  table.insert(newVirtText, {chunkText, hlGroup})
                  chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  -- str width returned from truncate() may less than 2nd argument, need padding
                  if curWidth + chunkWidth < targetWidth then
                      suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                  end
                  break
              end
              curWidth = curWidth + chunkWidth
          end

            newVirtText[1][1] = "  " .. newVirtText[1][1]
          table.insert(newVirtText, {suffix, 'MoreMsg'})
          return newVirtText
      end
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require('ufo').setup({
        fold_virt_text_handler = handler,
        provider_selector = function()
            return {'treesitter', 'indent'}
        end,
        -- fold_virt_text_handler = handler,
      })
    end
  },
}

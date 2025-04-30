 
local vim = vim
vim.o.backspace = '2'      -- more powerful backspacing

local map = vim.api.nvim_set_keymap

-- Don't write backup file if vim is being called by "crontab -e"
vim.cmd([[au BufWrite /private/tmp/crontab.* set nowritebackup]])
-- Don't write backup file if vim is being called by "chpass"
vim.cmd([[au BufWrite /private/etc/pw.* set nowritebackup]])
-- Execute pathogen#infect()
vim.cmd [[packadd packer.nvim]]

vim.g.signify_sign_add = '┃'
vim.g.signify_sign_change = '┃'
vim.g.signify_sign_delete = '•'
vim.g.signify_sign_show_count = 0
vim.g.context_highlight_tag = '<hide>'
vim.g.context_max_height = 3

-- ------ SETTERS ------
vim.g.indentLine_char = '|'
vim.g.markdown_folding = 1
vim.g.vim_jsx_pretty_colorful_config = 1
vim.g.vim_jsx_pretty_highlight_close_tag = 1
vim.g.vim_jsx_pretty_disable_js = 1
vim.o.number = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.laststatus = 2
-- Popup menu at the bottom of the page.
vim.o.pumblend = 4
vim.o.pumheight = 15
vim.o.signcolumn = 'yes'
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.statusline = "%#warningmsg# %*"
vim.o.hidden = true
vim.o.guicursor = "i:block"
-- vim.o.t_Co = 256
vim.o.showtabline = 2
vim.cmd("syntax on")


vim.o.cursorline = true

require('packer').startup(function(use)
   use {'vim-ruby/vim-ruby'}
   use {'tpope/vim-rails'}
   use {'neoclide/coc.nvim', branch = 'release' }
   use {'tpope/vim-fugitive'}
   use {'nvim-treesitter/nvim-treesitter'}
   use {'wellle/context.vim'}
   use {'Shatur/neovim-ayu'}
   use {'mitch1000/backpack'}
   use {'neovim/nvim-lspconfig'}
   use {'mhinz/vim-signify'}
   use {'pangloss/vim-javascript'}
   use {'darfink/vim-plist'}
   use {'Raimondi/delimitMate'}
   use {'joshdick/onedark.vim'}
   use {'lunacookies/vim-colors-xcode'}
   use {'romgrk/barbar.nvim'}
   use {
     'preservim/nerdcommenter',
   }
   use {
       "autozimu/LanguageClient-neovim",
       branch = "next",
   }
   use {
     "loctvl842/monokai-pro.nvim",
     config = function()
       require("monokai-pro").setup()
     end
   }
   use {
     "nvimdev/guard.nvim",
     requires = { 'nvimdev/guard-collection' },
     event = "BufReadPre",
     config = function()
      local ft = require("guard.filetype")

      ft("c,cpp"):fmt("clang-format")
     end
   }
   use { 'nvim-tree/nvim-web-devicons' }
   use {
     'nvim-lualine/lualine.nvim',
   }

   use {
     "nvim-neo-tree/neo-tree.nvim",
       branch = "v3.x",
       requires = {
         "mitch1000/backpack",
         "nvim-lua/plenary.nvim",
         "MunifTanjim/nui.nvim",
       }
     }
end)

 require("nvim-treesitter.configs").setup({
     highlight = { enable = true },
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
             ...
         },
         move = {
             enable = true,
             set_jumps = true,
             ...
         },
     },
 })

 require("neo-tree").setup {
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
 }
 local ruby_icon_object = {
    icon = "",
    color = "#db507e",
    cterm_color = "168",
    name = "Rb"
 }
 local git_icon_object = { icon = "", color = "#af5f5f", cterm_color = "160", name = "GitLogo" }

 require'nvim-web-devicons'.setup {
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
   --color_icons = true;
   -- default = true;
 }

 require('lualine').setup {
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
   }
 }

 -- Language Server Config Setups
 local lspconfig = require('lspconfig')
 local capabilities = require("lspconfig.configs").capabilities

 lspconfig.volar.setup({
    init_options = {
      --typescript = {
      --  tsdk = "/Users/dirtplantman/.nvm/versions/node/v22.14.0/lib/node_modules/typescript/lib",
      --}
    },
 })
--
-- lspconfig.ts_ls.setup({
--    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
--    init_options = {
--      plugins = {
--        {
--          languages = { 'vue' },
--        },
--      },
--    },
--  })

 lspconfig.pyright.setup{}
 lspconfig.java_language_server.setup{}
 lspconfig.html.setup{}

 lspconfig.ltex.setup({
   -- on_attach = on_attach,
   cmd = { "ltex-ls" },
   filetypes = { "markdown", "text" },
   flags = { debounce_text_changes = 300 },
 })

 vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP Actions',
      callback = function(args)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, {noremap = true, silent = true})
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {noremap = true, silent = true})
      end,
  })



 -- Enable filetype plugin and indent
 vim.cmd([[filetype plugin indent on]])
 -- Set background to dark
 vim.o.background = 'dark'
 vim.g.background_color = '#10141c'
 if vim.fn.has('termguicolors') == 1 then
   vim.o.termguicolors = true
 -- vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
 -- vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
 end


 vim.g.my_color_scheme = 'backpack'


 vim.g.italicize_comments = 1
 vim.g.backpack_contrast_dark = "medium" -- soft hard medium
 vim.g.backpack_contrast_light = "medium" -- soft hard medium
 vim.g.backpack_italic = 1
 -- vim.g.initial_background = vim.o.background
 vim.cmd('colorscheme ' .. vim.g.my_color_scheme)
 vim.cmd([[highlight LineNr guifg=#84848a]])

 -- Define custom functions
 -- Print a console.log() for each variable stored in g register
 function PrintJavascriptConsoleLogs()
   local variables_for_logging = vim.split(vim.fn.getreg('a'), " ,, ")
   for _, variable in ipairs(variables_for_logging) do
     if string.len(variable) > 0 then
       vim.cmd("execute \"normal! ccconsole.log('" .. variable .. "\\', " .. variable .. ");\\n\"")
     end
   end
   vim.fn.setreg("a", '')
 end

 -- Open the Tig Git terminal
 function GitLoad()
   vim.cmd("terminal tig")
   vim.cmd('starti')
   vim.fn.feedkeys('s')
 end

 -- Open the Tig Git terminal
 function GitBlame()
   vim.cmd("Git blame")
 end
 vim.cmd("let g:syntastic_java_checkers = []")

 -- Reload LightLine
 function ReloadLightLine()

   -- local source_file = "~/.vim/bundle/" .. vim.g.my_color_scheme .. "/autoload/lightline/colorscheme/" .. vim.g.my_color_scheme .. ".vim"
   -- local colors_source_file = "~/.vim/bundle/" .. vim.g.my_color_scheme .. "/colors/" .. vim.g.my_color_scheme .. ".vim"
   vim.cmd("execute 'source ' .. '~/.config/nvim/bundle/' .. g:my_color_scheme .. '/autoload/lightline/colorscheme/' .. g:my_color_scheme .. '.vim' | call lightline#colorscheme() | call lightline#update()")
 end

 function WaitThenOpenFile(open_clipboard)
   local file_to_open = ""
   if open_clipboard then
     vim.cmd('sleep 30m')  -- 15 milliseconds
     file_to_open = vim.fn.system("pbpaste")
   else
     file_to_open = vim.api.nvim_get_current_line()
   end

   local i,j = string.find(file_to_open, "M ")

   if i == 1 then
     file_to_open = string.sub(file_to_open, j, string.len(file_to_open))
   end
   vim.cmd('sleep 15m')  -- 15 milliseconds

   vim.cmd("edit " .. file_to_open)
 end

 -- Reset Git with Tig
 function TigReset()
   vim.cmd("Git reset")
   vim.cmd("call feedkeys('R')")
 end


 -- Get highlight group (color group) for
 -- item under the cursor to allow for setting syntax highlighting
 map('n', '<C-h>', [[:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>]], { noremap = true })

 -- Open the Neo Tree file browser
 map('n', '~', '%', { noremap = true })
 map('x', '~', '%', { noremap = true })
 map('n', '|', ':Neotree filesystem toggle left<CR><CR>', {
  noremap = true,
  silent = true
 })

 map('n', '_', ':q! <CR>', { noremap = true })
 -- Find and replace key mapping
 map('x', 'R', [[":s/" .. getreg('/') .."/"]], { expr = true, noremap = true })
 map('x', '*', [["wy :lua vim.fn.setreg('/', vim.fn.getreg('w'))<CR>]], { noremap = true, silent = true })
 -- Git terminal stuff
 map('t', '<Esc><Esc>', '<C-\\><C-n> <Cmd> close <CR>', { noremap = true, silent = true })
 map('t', '<C-c>', '<Cmd>Git commit <CR>', { noremap = true })
 map('t', '<C-a>', '<Cmd>Git commit --amend <CR>', { noremap = true })
 map('t', '<C-r>', '<Cmd>lua TigReset() <CR>', { noremap = true })
 map('t', '<C-e>', '<Esc><Esc><Cmd> echo nvim_get_current_line() lua WaitThenOpenFile() <CR>', { noremap = true })
 map('t', '<C-e>', '<Cmd>call feedkeys("E") | lua WaitThenOpenFile(true) <CR>', { noremap = true })
 --
 map('t', '<C-e>', 'E <Cmd>lua WaitThenOpenFile(true) <CR>', { noremap = true })
 map('n', '<C-e>', ':<C-U>call append(".", getline("."))<CR>', { noremap = true })
 map('n', '<C-e>', '<Cmd>lua WaitThenOpenFile(false) <CR>', { noremap = true })
 map('n', '<C-e>', 'E <Cmd>lua WaitThenOpenFile(true) <CR>', { noremap = true })

 function SetPaste()
   vim.cmd([[set paste]])
   -- Make sure press Ctrl-R
   -- They it would without the remap to allow use paste from the register
   vim.cmd([[call feedkeys("\<C-r>")]])
   -- Return to no paste after the register has been pasted
   vim.cmd([[autocmd TextChangedI * ++once set nopaste]])
 end

 map('i', '<C-r>', "<Cmd> lua SetPaste() <CR>", { noremap = true, silent = true })
 function CloseWindow()
   vim.cmd([[silent! close]])
 end

 map('n', '<C-e>', 'E <Cmd>lua WaitThenOpenFile(true) <CR>', { noremap = true })
 map('n', '<Esc>', '<Cmd>noh |  echon "" | lua CloseWindow() <CR>', { noremap = true })
 -- map('n', '<Esc><Esc>', '<Cmd>lua CloseWindow()<CR>', { noremap = true, silent = true })
 --- https://github.com/jhawthorn/fzy/pull/116#issuecomment-538708329
 vim.keymap.set('n', '˙', function () require'fzy'.History() end)
 vim.keymap.set('n', '†', function () require'fzy'.Oldfiles() end)
 vim.keymap.set('n', 'ß', function () require'fzy'.Buffers() end)
 vim.keymap.set('n', '®', function () require'fzy'.FindFile() end)
 vim.cmd([[command! -nargs=1 -complete=file S lua require'fzy'.Search(<f-args>)]])
 map('n', 'ff', [[:lua require"fzy".FindFile()<CR>]], { noremap = true, silent = true })

 -- For Console logs
 vim.fn.setreg("a", '')
 vim.fn.setreg("d", '')
 -- For Visual mode (xnoremap)
 map('x', '<C-m>', [["dy :lua vim.fn.setreg('a', vim.fn.getreg('d') .. ' ,, ' .. vim.fn.getreg('a'))<CR>]], { noremap = true, silent = true })
 -- For Normal mode (nnoremap)
 map('n', '<C-m>', [["dyiw :lua vim.fn.setreg('a', vim.fn.getreg('d') .. ' ,, ' .. vim.fn.getreg('a'))<CR>]], { noremap = true, silent = true })

 -- Copy to any register
 map('n', 'Y', '"*yy', { noremap = true })
 map('v', 'Y', '"*y<Esc>', { noremap = true })
 -- Force quit the buffer (tab)
 map('c', 'qq', ':bw!<CR>', { noremap = true })
 -- Quit the buffer (tab)
 map('n', 'tc', ':bw<CR>', { noremap = true })
 -- Force quit the buffer (tab)
 map('n', 'tcc', ':bw!<CR>', { noremap = true })
 --
 -- Comment
 map('v', 'gc', '<plug>NERDCommenterToggle', { noremap = true })
 map('n', 'gc', '<plug>NERDCommenterToggle', { noremap = true })

 -- Define custom commands
 -- Remove extra spaces at end of the lines
 map('i', 'CONS', '<Esc>:lua PrintJavascriptConsoleLogs()<CR>', { noremap = true, silent = true })
 vim.cmd([[command! Clean :%s/\s\+$//e]])
 vim.cmd([[command! GL :lua GitLoad()]])
 vim.cmd([[command! GB :lua GitBlame()]])
 vim.cmd([[command! CONS :lua PrintJavascriptConsoleLogs()]])
 vim.cmd([[command! CL :lua vim.fn.setreg("a", '')]])
 vim.cmd([[command! BD :set background=dark]])
 vim.cmd([[command! BL :set background=light]])

 -- Go to next linter error
 vim.cmd([[command! AN call CocAction('diagnosticNext')]])
 -- Go to previous linter error
 vim.cmd([[command! AP call CocAction('diagnosticPrevious')]])
 -- Redraw the vim screen
 vim.cmd([[command! RF syntax sync fromstart]])
 -- Reload vimrc and lightline theme
 vim.cmd([[command! RL source $MYVIMRC | lua ReloadLightLine()]])

 vim.g.lightline_bufferline_show_number = 1
 function ReloadConfig()
   local luacache = (_G.__luacache or {}).cache
   -- TODO unload commands, mappings + ?symbols?
   for pkg, _ in pairs(package.loaded) do
     if pkg:match '^my_.+'
     then
       print(pkg)
       package.loaded[pkg] = nil
       if luacache then
         lucache[pkg] = nil
       end
     end
   end
   dofile(vim.env.MYVIMRC)
   vim.notify('Config reloaded!', vim.log.levels.INFO)
 end
 -- Convert from snake_case to camelCase
 vim.cmd([[command! -range CC <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])
 vim.cmd([[command! -range CamelCase <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])

 -- Define auto commands

 vim.cmd([[autocmd OptionSet background
        \ execute 'source' '~/.config/nvim/bundle/backpack/autoload/lightline/colorscheme/backpack.vim'
        \ | call lightline#colorscheme() | call lightline#update()]])
 -- vim.cmd([[autocmd TermEnter * execute "set background=dark | lua ReloadLightLine()"]])
 -- vim.cmd([[autocmd TermOpen * execute "set background=dark | lua ReloadLightLine()"]])
 vim.cmd([[autocmd TermEnter * execute "highlight LineNr guifg=" .. g:background_color[0] ]])
 vim.cmd([[autocmd TermEnter * execute "highlight LineNr guibg=" .. g:background_color[0] ]])
 vim.cmd([[autocmd TermEnter * execute "highlight CursorLineNr guifg=" .. g:background_color[0] ]])
 vim.cmd([[autocmd TermLeave * execute "highlight LineNr guifg=" .. g:line_nr[0] ]])
 vim.cmd([[autocmd TermLeave * execute "highlight CursorLineNr guifg=" .. g:line_nr[0] ]])
 -- vim.cmd([[autocmd TermLeave * execute "set background=" .. g:initial_background .. " | lua ReloadLightLine()"]])
 vim.cmd([[autocmd BufNewFile,BufRead *.jst set filetype=html]])
 vim.cmd([[autocmd BufRead,BufNewFile *.rabl setf ruby]])
 vim.cmd([[autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css || TSBufDisable highlight]])
 vim.cmd([[autocmd BufRead,BufNewFile *.js TSBufDisable highlight]])
 vim.cmd([[autocmd BufRead,BufNewFile *.html TSBufDisable highlight]])
 vim.cmd([[autocmd BufRead,BufNewFile *.scss TSBufDisable highlight]])
 vim.cmd([[autocmd BufRead,BufNewFile *.css TSBufDisable highlight]])
 vim.cmd([[autocmd BufRead,BufNewFile *.vue syntax sync fromstart]])

 function BufferOrderByBufferNumberSafe()
   if vim.fn.exists(":BufferOrderByBufferNumber") > 0 then
      vim.cmd([[BufferOrderByBufferNumber]])
   end
 end

 vim.cmd([[autocmd BufRead,BufNewFile * execute "lua BufferOrderByBufferNumberSafe()"]])

 -- -------------------------------------------------------------------
 -- --------------------COC VIM ---------------------------------------
 -- -------------------------------------------------------------------
 --
 --
 --- Some servers have issues with backup files, see #649
 vim.opt.backup = false
 vim.opt.writebackup = false

 -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
 -- delays and poor user experience
 vim.opt.updatetime = 300

 local keyset = vim.keymap.set
 -- Autocomplete
 function _G.check_back_space()
     local col = vim.fn.col('.') - 1
     return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
 end

 -- Use Tab for trigger completion with characters ahead and navigate
 -- NOTE: There's always a completion item selected by default, you may want to enable
 -- no select by setting `"suggest.noselect": true` in your configuration file
 -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
 -- other plugins before putting this into your config
 local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
 keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
 keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

 -- Make <CR> to accept selected completion item or notify coc.nvim to format
 -- <C-g>u breaks current undo, please make your own choice
 keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

 -- Use <c-j> to trigger snippets
 keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
 -- Use <c-space> to trigger completion
 keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

 -- Use `[g` and `]g` to navigate diagnostics
 -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
 keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
 keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

 -- GoTo code navigation
 keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
 keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
 keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
 keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


 -- Use K to show documentation in preview window
 function _G.show_docs()
     local cw = vim.fn.expand('<cword>')
     if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
         vim.api.nvim_command('h ' .. cw)
     elseif vim.api.nvim_eval('coc#rpc#ready()') then
         vim.fn.CocActionAsync('doHover')
     else
         vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
     end
 end
 keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

 function CocActionAsyncSafe(action)
   if vim.fn.exists(":CocList") > 0 then
     vim.fn.CocActionAsync(action)
   end
 end

 -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
 vim.api.nvim_create_augroup("CocGroup", {})
 vim.api.nvim_create_autocmd("CursorHold", {
     group = "CocGroup",
     command = "silent lua CocActionAsyncSafe('highlight')",
     desc = "Highlight symbol under cursor on CursorHold"
 })


 -- Symbol renaming
 keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


 -- Formatting selected code
 keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
 keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


 -- Setup formatexpr specified filetype(s)
 vim.api.nvim_create_autocmd("FileType", {
     group = "CocGroup",
     pattern = "typescript,json",
     command = "setl formatexpr=CocAction('formatSelected')",
     desc = "Setup formatexpr specified filetype(s)."
 })

 -- Update signature help on jump placeholder
 vim.api.nvim_create_autocmd("User", {
     group = "CocGroup",
     pattern = "CocJumpPlaceholder",
     command = "call CocActionAsyncSafe('showSignatureHelp')",
     desc = "Update signature help on jump placeholder"
 })

 -- Apply codeAction to the selected region
 -- Example: `<leader>aap` for current paragraph
 opts = { silent = true, nowait = true }
 keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
 keyset("n", "<leader>ac", "<Plug>(coc-codeaction-selected)", opts)

 -- Remap keys for apply code actions at the cursor position.
 keyset("n", "<leader>a", "<Plug>(coc-codeaction-cursor)", opts)
 -- Remap keys for apply source code actions for current file.
 keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
 -- Apply the most preferred quickfix action on the current line.
 keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

 -- keyset('n', '<D-h', ':bn<CR>', { noremap = true })
 -- -- Previous buffer (tab)
 -- keyset('n', '<D-l', ':bp<CR>', { noremap = true })

 -- Remap keys for apply refactor code actions.
 keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
 keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
 keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
 keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

 -- Run the Code Lens actions on the current line
 keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


 -- Map function and class text objects
 -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
 keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
 keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
 keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
 keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
 keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
 keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
 keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
 keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


 -- Remap <C-f> and <C-b> to scroll float windows/popups
 ---@diagnostic disable-next-line: redefined-local
 local opts = {silent = true, nowait = true, expr = true}

 -- Use CTRL-S for selections ranges
 -- Requires 'textDocument/selectionRange' support of language server
 keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
 keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


 -- Add `:Format` command to format current buffer
 vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

 -- " Add `:Fold` command to fold current buffer
 vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

 -- Add `:OR` command for organize imports of the current buffer
 vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

 -- Add (Neo)Vim's native statusline support
 -- NOTE: Please see `:h coc-status` for integrations with external plugins that
 -- provide custom statusline: lightline.vim, vim-airline
 -- vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

 -- Mappings for CoCList
 -- code actions and coc stuff
 ---@diagnostic disable-next-line: redefined-local
 local opts = {silent = true, nowait = true}
 -- Show all diagnostics
 keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
 -- Manage extensions
 keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
 -- Show commands
 keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
 -- Find symbol of current document
 keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
 -- Search workspace symbols
 keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
 -- Do default action for next item
 keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
 -- Do default action for previous item
 keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
 -- Resume latest coc list
 keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

 -- For window borders

 vim.lsp.handlers["textDocument/hover"] =
   vim.lsp.with(
   vim.lsp.handlers.hover,
   {
     border = "single"
   }
 )

 vim.lsp.handlers["textDocument/signatureHelp"] =
   vim.lsp.with(
   vim.lsp.handlers.signature_help,
   {
     border = "single"
   }
 )

 vim.cmd [[nnoremap <buffer><silent> <C-space> :lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>]]
 vim.cmd [[nnoremap <buffer><silent> ]g :lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>]]
 vim.cmd [[nnoremap <buffer><silent> [g :lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>]]

 -- Do not forget to use the on_attach function
 -- To instead override globally
 vim.diagnostic.config({
   virtual_text = true,
   signs = true,
   underline = true,
   update_in_insert = false,
   severity_sort = false,
 })

 local sign_define = vim.fn.sign_define
 sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
 sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
 sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
 sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

 function OpenWin(file_name)
   local width = vim.o.columns - 4
   local height = 32
   if (vim.o.columns >= 85) then
       width = 110
   end
   vim.api.nvim_open_win(
       vim.api.nvim_create_buf(false, true),
       true,
       {
           relative = 'editor',
           style = 'minimal',
           border = "none",
           noautocmd = true,
           width = width,
           height = height,
           col = math.min((vim.o.columns - width) / 2),
           row = math.min((vim.o.lines - height) / 2 - 1),
       }
   )
   vim.cmd("edit " .. file_name)
 end

 function TrailerTrim()
   vim.cmd([[%s/\s\+$//e]])
 end

 function Close()
   vim.cmd([[q]])
 end

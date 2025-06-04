local cmd = vim.cmd
local vim = vim

-- Don't write backup file if vim is being called by "crontab -e"
cmd([[au BufWrite /private/tmp/crontab.* set nowritebackup]])
-- Don't write backup file if vim is being called by "chpass"
cmd([[au BufWrite /private/etc/pw.* set nowritebackup]])

cmd("syntax on")
-- Enable filetype plugin and indent
cmd([[filetype plugin indent on]])

local colorscheme = vim.g.my_color_scheme or ""
cmd('colorscheme ' .. colorscheme)

cmd([[command! -nargs=1 -complete=file S lua require'fzy'.Search(<f-args>)]])
-- For Console logs
vim.fn.setreg("a", '')
vim.fn.setreg("d", '')

cmd([[command! Clean :%s/\s\+$//e]])
cmd([[command! GL :lua GitLoad()]])
cmd([[command! GB :lua GitBlame()]])
cmd([[command! CONS :lua PrintJavascriptConsoleLogs()]])
cmd([[command! CL :lua vim.fn.setreg("a", '')]])
-- cmd([[command! BD :set background=dark]])
-- cmd([[command! BL :set background=light]])

-- Go to next linter error
cmd([[command! AN call CocAction('diagnosticNext')]])
-- Go to previous linter error
cmd([[command! AP call CocAction('diagnosticPrevious')]])
-- Redraw the vim screen
cmd([[command! RF syntax sync fromstart]])
-- Reload vimrc and lightline theme
cmd([[command! RL source $MYVIMRC | lua ReloadLightLine()]])

-- Convert from snake_case to camelCase
cmd([[command! -range CC <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])
cmd([[command! -range CamelCase <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])

-- Define auto commands

-- cmd([[autocmd OptionSet background
--       \ execute 'source' '~/.config/nvim/bundle/backpack/autoload/lightline/colorscheme/backpack.vim'
--       \ | call lightline#colorscheme() | call lightline#update()]])
-- cmd([[autocmd TermEnter * execute "highlight LineNr guifg=" .. g:background_color[0] ]])
-- cmd([[autocmd TermEnter * execute "highlight LineNr guibg=" .. g:background_color[0] ]])
-- cmd([[autocmd TermEnter * execute "highlight CursorLineNr guifg=" .. g:background_color[0] ]])
-- cmd([[autocmd TermLeave * execute "highlight LineNr guifg=" .. g:line_nr[0] ]])
-- cmd([[autocmd TermLeave * execute "highlight CursorLineNr guifg=" .. g:line_nr[0] ]])

cmd([[autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css || TSBufDisable highlight]])

cmd([[autocmd BufRead,BufNewFile * execute "lua BufferOrderByBufferNumberSafe()"]])
cmd([[autocmd BufRead,BufNewFile, * execute "lua MF()"]])
cmd([[autocmd CursorMoved,CursorMovedI * execute "lua MF()"]])
function OpenFold()
  MF()
  vim.cmd([[foldopen]])

  -- os.execute("sleep " .. tonumber(1))
  print("open")
  MF()
end

function OpenFold()
  MF()
  vim.cmd([[foldopen]])

  -- os.execute("sleep " .. tonumber(1))
  print("open")
  MF()
end

function CloseFold()
  MF()
  vim.cmd([[foldclose]])
  MF()
end

function CloseFold()
  MF()
  vim.cmd([[foldclose]])
  MF()
end

vim.cmd([[nnoremap zo <cmd>execute "lua OpenFold()"<CR>]])
vim.cmd([[nnoremap zc <cmd>execute "lua CloseFold()"<CR>]])
-- vim.keymap.set("n", "zo", [[za && execute "lua MF(' ')]], {silent = true, remap = true})

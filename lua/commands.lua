local cmd = vim.cmd
local vim = vim

-- Don't write backup file if vim is being called by "crontab -e"
cmd([[au BufWrite /private/tmp/crontab.* set nowritebackup]])
-- Don't write backup file if vim is being called by "chpass"
cmd([[au BufWrite /private/etc/pw.* set nowritebackup]])

cmd("syntax on")
-- Enable filetype plugin and indent
cmd([[filetype plugin indent on]])

cmd([[command! -nargs=1 -complete=file S lua require'fzy'.Search(<f-args>)]])
-- For Console logs
vim.fn.setreg("a", '')
vim.fn.setreg("d", '')

cmd([[command! Clean :%s/\s\+$//e]])
cmd([[command! GL :lua GitLoad()]])
cmd([[command! GB :lua GitBlame()]])
cmd([[command! CONS :lua PrintJavascriptConsoleLogs()]])
cmd([[command! CL :lua vim.fn.setreg("a", '')]])

-- Go to next linter error
cmd([[command! AN call CocAction('diagnosticNext')]])
-- Go to previous linter error
cmd([[command! AP call CocAction('diagnosticPrevious')]])
-- Redraw the vim screen
cmd([[command! RF syntax sync fromstart]])
-- Reload vimrc and lightline theme
cmd([[command! RL source $MYVIMRC]])

-- Convert from snake_case to camelCase
cmd([[command! -range CC <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])
cmd([[command! -range CamelCase <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])


cmd([[autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css || TSBufDisable highlight]])


cmd([[autocmd BufRead,BufNewFile * execute "lua BufferOrderByBufferNumberSafe()"]])

local HandleTabIcons = require('components.handle_tab_icons')
function TabIcons()
  if vim.g.my_color_scheme == "backpack" then
    HandleTabIcons()
  end
end
cmd([[autocmd BufWinEnter * execute "lua TabIcons()"]])

vim.cmd([[nmap zo <cmd>execute "foldopen"<CR>]])
vim.cmd([[nmap zc <cmd>execute "foldclose"<CR>]])

SetColorScheme = require('helpers.set_color_scheme')
SetColorScheme(vim.g.my_color_scheme)

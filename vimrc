" Configuration file for vim
set modelines=0         " CVE-2007-2438 "
" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible        " Use Vim defaults instead of 100% vi compatibility
set backspace=2         " more powerful backspacing
" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup
execute pathogen#infect()
call pathogen#helptags()
set t_Co=256
syntax on
filetype plugin on
map <C-n> :NERDTreeToggle<CR>
ca tt tabnew
ca tc tabclose 
nnoremap tr :tabp<CR>
nnoremap ty :tabn<CR>
command! RF syntax sync fromstart 
nmap <Up> :.w !pbcopy<CR><CR>
vmap <Up> :w !pbcopy<CR><CR>


set number

au BufNewFile,BufRead *.jst set filetype=html
au BufRead,BufNewFile *.rabl setf ruby

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
autocmd FileType vue syntax sync fromstart

set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

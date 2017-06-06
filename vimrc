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
runtime macros/matchit.vim
colorscheme minimalist
map <C-n> :NERDTreeToggle<CR>
ca tt tabnew
ca tc tabclose 
nnoremap tr :tabp<CR>
nnoremap ty :tabn<CR>
set number
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
nmap <Up> :.w !pbcopy<CR><CR>
vmap <Up> :w !pbcopy<CR><CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
so ~/.vim/bundle/delimitMate/test/_setup.vim
let delimitMate_expand_cr = 1

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

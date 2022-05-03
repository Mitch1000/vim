" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible        " Use Vim defaults instead of 100% vi compatibility
set backspace=2         " more powerful backspacing
" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

execute pathogen#infect()

filetype plugin indent on

" For dark version.
set background=dark
let g:italicize_comments=1
let g:backpack_italic=1

autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
autocmd FileType vue syntax sync fromstart

colorscheme backpack 
let g:lightline = {
      \ 'colorscheme': 'backpack',
      \ }

syntax on

set cursorline

hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END

let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit':  'BrightHighlightOff', }

set t_Co=256

call pathogen#helptags()

set hidden
map <C-n> :NERDTreeToggle<CR>
command! RF syntax sync fromstart
nmap <Up> :.w !pbcopy<CR><CR>
vmap <Up> :w !pbcopy<CR><CR>
vmap oo <plug>NERDCommenterToggle
nmap oo <plug>NERDCommenterToggle

ca qq :bw! <CR>
nmap tr :bp <CR>
nmap ty :bn <CR>
nmap tt :ls <CR>

set number
set laststatus=2

au BufNewFile,BufRead *.jst set filetype=html
au BufRead,BufNewFile *.rabl setf ruby

set statusline+=%#warningmsg#
set statusline+=%*

" Linter configuration
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \}

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

let b:ale_linters = ['eslint']


set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

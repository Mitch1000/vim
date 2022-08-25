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
let g:italicize_comments=1
let g:backpack_italic=1

let g:current_color_scheme = 'backpack'

" set t_Co=256

"if has('termguicolors')
"  set termguicolors
"endif
set showtabline=2
colorscheme backpack
let g:lightline = {
      \ 'colorscheme': 'backpack',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\ }


let g:lightline#bufferline#show_number = 1
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

syntax on

set hidden

" Give me number hilighting
set cursorline
"Hide the cursor line only hightlight the number
"hi clear CursorLine
"augroup CLClear
    "autocmd! ColorScheme * hi clear CursorLine
"augroup END

call pathogen#helptags()

map <C-n> :NERDTreeToggle<CR>
command! RF syntax sync fromstart
nmap <Up> :.w !pbcopy<CR><CR>
vmap <Up> :w !pbcopy<CR><CR>
vmap oo <plug>NERDCommenterToggle
nmap oo <plug>NERDCommenterToggle
map Y y$
ca qq :bw! <CR>
nmap tc :bw <CR>
nmap tcc :bw! <CR>
nmap tr :bp <CR>
nmap ty :bn <CR>
nmap tt :ls <CR>
"Remove extra spaces at end of the lines
command! Clean :%s/\s\+$//e

set number
set laststatus=2

au BufNewFile,BufRead *.jst set filetype=html
au BufRead,BufNewFile *.rabl setf ruby

set statusline+=%#warningmsg#
set statusline+=%*

" Linter configuration
let g:ale_linters = {
  \'javascript': ['eslint'],
\}

let g:ale_fixers = {
  \'javascript': ['eslint'],
\}

let b:ale_linters = ['eslint']

autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
autocmd BufRead,BufNewFile *.vue syntax sync fromstart
autocmd FileType vue syntax sync fromstart

set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

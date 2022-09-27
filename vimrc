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

let g:italicize_comments=1
let g:backpack_contrast_dark = "medium" " soft hard medium
let g:backpack_contrast_light = "medium" " soft hard medium
let g:backpack_italic=1
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

set background=dark

" Use more basic set of 256 colors giving less color options for text
set t_Co=256

" Create two spaces with tab is pressed
set showtabline=2

autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

" Give me number hilighting
set cursorline
"Hide the cursor line only hightlight the number
"hi clear CursorLine
"augroup CLClear
    "autocmd! ColorScheme * hi clear CursorLine
"augroup END

syntax on

set hidden

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme backpack

call pathogen#helptags()

function! ReloadLightLine()
  source ~/.vim/bundle/backpack/autoload/lightline/colorscheme/backpack.vim
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
  call lightline#disable()
  call lightline#enable()
endfunction

map <C-n> :NERDTreeToggle<CR>
command! RF syntax sync fromstart
command! RL source $MYVIMRC | call ReloadLightLine()
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

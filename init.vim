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

" Setting Your Color Scheme 
let g:my_color_scheme='backpack'
set background=dark


let g:italicize_comments=1
let g:backpack_contrast_dark = "medium" " soft hard medium
let g:backpack_contrast_light = "medium" " soft hard medium
let g:backpack_italic=1
let g:NERDTreeQuitOnOpen = 1
let g:lightline = {
      \ 'colorscheme': g:my_color_scheme,
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

let g:indentLine_char = '|'
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

set guicursor=i:block

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

execute 'colorscheme ' .. g:my_color_scheme 

call pathogen#helptags()

autocmd OptionSet background
      \ execute 'source' '~/.config/nvim/bundle/backpack/autoload/lightline/colorscheme/backpack.vim'
      \ | call lightline#colorscheme() | call lightline#update()

function! ReloadLightLine()
  let source_file = "~/.vim/bundle/" . g:my_color_scheme . "/autoload/lightline/colorscheme/" . g:my_color_scheme . ".vim"
  let colors_source_file = "~/.vim/bundle/" . g:my_color_scheme . "/colors/" . g:my_color_scheme . ".vim"
  execute 'source' '~/.config/nvim/bundle/' . g:my_color_scheme . '/autoload/lightline/colorscheme/' . g:my_color_scheme . '.vim'
   \ | call lightline#colorscheme() | call lightline#update()
  " call lightline#disable()
  " call lightline#init()
  " call lightline#enable()
endfunction

" Open the Nerd Tree file browser
map <C-n> :NERDTreeToggle<CR>
" Find and replace key mapping
xnoremap <expr> R ":s/".getreg("/")."/"
xnoremap <silent> <expr> * "\"wy:call setreg('/', getreg('w'))<CR>" 
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <C-f> <Space>
tnoremap <C-b> <->

" Go to next linter error
command! AN ALENext<CR>
" Go to previous linter error
command! AP ALEPrevious<CR>
" Redraw the vim screen
command! RF syntax sync fromstart
" Reload vimrc and lightline theme
command! RL source $MYVIMRC | call ReloadLightLine()

" Convert from snake_case to camelCase
command -range CC <line1>,<line2>s/\(_\)\(.\)/\u\2/g
command -range CamelCase <line1>,<line2>s/\(_\)\(.\)/\u\2/g
" Comment
vmap oo <plug>NERDCommenterToggle
nmap oo <plug>NERDCommenterToggle

" Print a console.log() for each variable stored in g register
function PrintJavascriptConsoleLogs()
  let variables_for_logging = split(getreg('g'), " ,, ")
  for variable in variables_for_logging
    execute "normal! ccconsole.log('" . variable . ":', " . variable . ");\n"
  endfor
  return setreg("g", "")
endfunction

" if mode() == "t"
"   set background=dark
" end


function GitLoad()
  execute "terminal tig"
  startinsert 
  call feedkeys('s')
endfunction

let g:initial_background=&background

au TermEnter * execute "set background=dark | call ReloadLightLine()"
au TermOpen * set background=dark 

au TermEnter * execute "highlight LineNr guifg=" . g:background_color[0]
au TermEnter * execute "highlight LineNr guibg=" . g:background_color[0]
au TermEnter * execute "highlight CursorLineNr guifg=" . g:background_color[0]

au TermLeave * execute "highlight LineNr guifg=" . g:line_nr[0]
au TermLeave * execute "highlight CursorLineNr guifg=" . g:line_nr[0]

au TermLeave * execute "set background=" . g:initial_background . " | call ReloadLightLine()"

imap CONS <Esc>:call PrintJavascriptConsoleLogs()<CR>
command! CONS :call PrintJavascriptConsoleLogs()
command! CL :call setreg("g", "")
xnoremap <silent> <expr> <C-m> "\"dy :call setreg('g',  getreg('d') . ' ,, ' . getreg('g'))<CR>"
nnoremap <silent> <expr> <C-m> "\"dyiw :call setreg('g',  getreg('d') . ' ,, ' . getreg('g'))<CR>"
nmap <Esc> :noh<CR>:echon '' <CR>

 
" Copy to any register
nmap Y "*yy
vmap Y "*y <Esc> 
" Force quit the buffer (tab)
ca qq :bw! <CR>
" Quit the buffer (tab)
nmap tc :bw <CR>
" Force quit the buffer (tab)
nmap tcc :bw! <CR>
" Previous buffer (tab)
nmap tr :bp <CR>
" Next buffer (tab)
nmap ty :bn <CR>
" List buffers (tab)
nmap tt :ls <CR>
"Remove extra spaces at end of the lines
command! Clean :%s/\s\+$//e
command! GL :call GitLoad()

"Remove extra spaces at end of the lines
set number
set cindent
set autoindent
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
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
autocmd BufRead,BufNewFile *.vue syntax sync fromstart
autocmd FileType vue syntax sync fromstart
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

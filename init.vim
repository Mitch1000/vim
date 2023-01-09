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

function! ReloadLightLine()
  " let source_file = "~/.vim/bundle/" . g:my_color_scheme . "/autoload/lightline/colorscheme/" . g:my_color_scheme . ".vim"
  " execute 'source ' .. source_file
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
  call lightline#disable()
  call lightline#enable()
endfunction

" Open the Nerd Tree file browser
map <C-n> :NERDTreeToggle<CR>
" Find and replace key mapping
xnoremap <expr> R ":s/".getreg("/")."/"
xnoremap <silent> <expr> * "\"wy:call setreg('/', getreg('w'))<CR>" 

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

let g:palette = [
    \ '#000000', '#800000', '#008000', '#808000', '#000080', '#800080', '#008080', '#c0c0c0',
    \ '#808080', '#ff0000', '#00ff00', '#ffff00', '#0000ff', '#ff00ff', '#00ffff', '#ffffff',
    \ '#000000', '#00005f', '#000087', '#0000af', '#0000d7', '#0000ff', '#005f00', '#005f5f',
    \ '#005f87', '#005faf', '#005fd7', '#005fff', '#008700', '#00875f', '#008787', '#0087af',
    \ '#0087d7', '#0087ff', '#00af00', '#00af5f', '#00af87', '#00afaf', '#00afd7', '#00afff',
    \ '#00d700', '#00d75f', '#00d787', '#00d7af', '#00d7d7', '#00d7ff', '#00ff00', '#00ff5f',
    \ '#00ff87', '#00ffaf', '#00ffd7', '#00ffff', '#5f0000', '#5f005f', '#5f0087', '#5f00af',
    \ '#5f00d7', '#5f00ff', '#5f5f00', '#5f5f5f', '#5f5f87', '#5f5faf', '#5f5fd7', '#5f5fff',
    \ '#5f8700', '#5f875f', '#5f8787', '#5f87af', '#5f87d7', '#5f87ff', '#5faf00', '#5faf5f',
    \ '#5faf87', '#5fafaf', '#5fafd7', '#5fafff', '#5fd700', '#5fd75f', '#5fd787', '#5fd7af',
    \ '#5fd7d7', '#5fd7ff', '#5fff00', '#5fff5f', '#5fff87', '#5fffaf', '#5fffd7', '#5fffff',
    \ '#870000', '#87005f', '#870087', '#8700af', '#8700d7', '#8700ff', '#875f00', '#875f5f',
    \ '#875f87', '#875faf', '#875fd7', '#875fff', '#878700', '#87875f', '#878787', '#8787af',
    \ '#8787d7', '#8787ff', '#87af00', '#87af5f', '#87af87', '#87afaf', '#87afd7', '#87afff',
    \ '#87d700', '#87d75f', '#87d787', '#87d7af', '#87d7d7', '#87d7ff', '#87ff00', '#87ff5f',
    \ '#87ff87', '#87ffaf', '#87ffd7', '#87ffff', '#af0000', '#af005f', '#af0087', '#af00af',
    \ '#af00d7', '#af00ff', '#af5f00', '#af5f5f', '#af5f87', '#af5faf', '#af5fd7', '#af5fff',
    \ '#af8700', '#af875f', '#af8787', '#af87af', '#af87d7', '#af87ff', '#afaf00', '#afaf5f',
    \ '#afaf87', '#afafaf', '#afafd7', '#afafff', '#afd700', '#afd75f', '#afd787', '#afd7af',
    \ '#afd7d7', '#afd7ff', '#afff00', '#afff5f', '#afff87', '#afffaf', '#afffd7', '#afffff',
    \ '#d70000', '#d7005f', '#d70087', '#d700af', '#d700d7', '#d700ff', '#d75f00', '#d75f5f',
    \ '#d75f87', '#d75faf', '#d75fd7', '#d75fff', '#d78700', '#d7875f', '#d78787', '#d787af',
    \ '#d787d7', '#d787ff', '#d7af00', '#d7af5f', '#d7af87', '#d7afaf', '#d7afd7', '#d7afff',
    \ '#d7d700', '#d7d75f', '#d7d787', '#d7d7af', '#d7d7d7', '#d7d7ff', '#d7ff00', '#d7ff5f',
    \ '#d7ff87', '#d7ffaf', '#d7ffd7', '#d7ffff', '#ff0000', '#ff005f', '#ff0087', '#ff00af',
    \ '#ff00d7', '#ff00ff', '#ff5f00', '#ff5f5f', '#ff5f87', '#ff5faf', '#ff5fd7', '#ff5fff',
    \ '#ff8700', '#ff875f', '#ff8787', '#ff87af', '#ff87d7', '#ff87ff', '#ffaf00', '#ffaf5f',
    \ '#ffaf87', '#ffafaf', '#ffafd7', '#ffafff', '#ffd700', '#ffd75f', '#ffd787', '#ffd7af',
    \ '#ffd7d7', '#ffd7ff', '#ffff00', '#ffff5f', '#ffff87', '#ffffaf', '#ffffd7', '#ffffff',
    \ '#080808', '#121212', '#1c1c1c', '#262626', '#303030', '#3a3a3a', '#444444', '#4e4e4e',
    \ '#585858', '#606060', '#666666', '#767676', '#808080', '#8a8a8a', '#949494', '#9e9e9e',
    \ '#a8a8a8', '#b2b2b2', '#bcbcbc', '#c6c6c6', '#d0d0d0', '#dadada', '#e4e4e4', '#eeeeee',
    \ ]


function! Convert256ToHexInLine(color, i)
  let line_number = search("=\*['#\.\*', " . a:i . "\\]\\n", "w")
  let line_containing_hex = getline(line_number)
  let split_line = split(line_containing_hex, "'")

  let old_hex_value = ""
  for word in split_line
    if stridx(word, "#") != -1
      let old_hex_value = word
    endif
  endfor
  let new_line = substitute(line_containing_hex, old_hex_value, a:color, "g") . " \"Converted"
  call setline(line_number, new_line)
endfunction

function! Convert256ToHexInFile()
  let i = 0
  for color in g:palette
    while search("=\*['#\.\*', " . i . "\\]\\n", "w") != 0
      call Convert256ToHexInLine(color, i)
    endwhile

    let i += 1
  endfor

  let l = 1
  for line in getline(1,"$")
      call setline(l, substitute(line, " \"Converted", "", "g"))
      let l = l + 1
  endfor
endfunction

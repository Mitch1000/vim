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

set background=dark

" Setting Your Color Scheme 
let g:my_color_scheme='backpack'
let g:italicize_comments=1
let g:backpack_contrast_dark = "medium" " soft hard medium
let g:backpack_contrast_light = "medium" " soft hard medium
let g:backpack_italic=1
let g:initial_background=&background
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

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

execute 'colorscheme ' .. g:my_color_scheme 

call pathogen#helptags()

" ------ FUNCTIONS ------
" Print a console.log() for each variable stored in g register
function PrintJavascriptConsoleLogs()
  let variables_for_logging = split(getreg('a'), " ,, ")
  for variable in variables_for_logging
    execute "normal! ccconsole.log('" . variable . ":', " . variable . ");\n"
  endfor
  return setreg("a", "")
endfunction

function GitLoad()
  execute "terminal tig"
  startinsert 
  call feedkeys('s')
endfunction

function! ReloadLightLine()
  let source_file = "~/.vim/bundle/" . g:my_color_scheme . "/autoload/lightline/colorscheme/" . g:my_color_scheme . ".vim"
  let colors_source_file = "~/.vim/bundle/" . g:my_color_scheme . "/colors/" . g:my_color_scheme . ".vim"
  execute 'source' '~/.config/nvim/bundle/' . g:my_color_scheme . '/autoload/lightline/colorscheme/' . g:my_color_scheme . '.vim'
   \ | call lightline#colorscheme() | call lightline#update()
  " call lightline#disable()
  " call lightline#init()
  " call lightline#enable()
endfunction

function WaitThenOpenFile()
  sleep 15m
  execute "edit " . getreg('+')
endfunction

function TigReset()
  execute "Git reset"
  execute "call feedkeys('R')"
endfunction

" Open the Nerd Tree file browser
map <C-n> :NERDTreeToggle<CR>
" Find and replace key mapping
xnoremap <expr> R ":s/".getreg("/")."/"
xnoremap <silent> <expr> * "\"wy:call setreg('/', getreg('w'))<CR>" 
" Git terminal stuff
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <C-c> <Cmd>Git commit <CR>
tnoremap <C-a> <Cmd>Git commit --amend <CR>
tnoremap <C-r> <Cmd> call TigReset() <CR>
tnoremap <C-e> E<Cmd> call WaitThenOpenFile() <CR>

nmap <C-e> getline('.')

xnoremap <silent> <expr> <C-m> "\"dy :call setreg('a',  getreg('d') . ' ,, ' . getreg('a'))<CR>"
nnoremap <silent> <expr> <C-m> "\"dyiw :call setreg('a',  getreg('d') . ' ,, ' . getreg('a'))<CR>"

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

" Comment
vmap oo <plug>NERDCommenterToggle
nmap oo <plug>NERDCommenterToggle

" ------- COMMANDS -------
"Remove extra spaces at end of the lines
command! Clean :%s/\s\+$//e

imap CONS <Esc>:call PrintJavascriptConsoleLogs()<CR>
command! GL :call GitLoad()
command! CONS :call PrintJavascriptConsoleLogs()
command! CL :call setreg("a", "")
command! BD :set background=dark
command! BL :set background=light

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


" ------ AUTO COMMANDS ------

au OptionSet background
       \ execute 'source' '~/.config/nvim/bundle/backpack/autoload/lightline/colorscheme/backpack.vim'
       \ | call lightline#colorscheme() | call lightline#update()

au TermEnter * execute "set background=dark | call ReloadLightLine()"
au TermOpen * execute "set background=dark | call ReloadLightLine()"

au TermEnter * execute "highlight LineNr guifg=" . g:background_color[0]
au TermEnter * execute "highlight LineNr guibg=" . g:background_color[0]
au TermEnter * execute "highlight CursorLineNr guifg=" . g:background_color[0]

au TermLeave * execute "highlight LineNr guifg=" . g:line_nr[0]
au TermLeave * execute "highlight CursorLineNr guifg=" . g:line_nr[0]

au TermLeave * execute "set background=" . g:initial_background . " | call ReloadLightLine()"

au BufNewFile,BufRead *.jst set filetype=html
au BufRead,BufNewFile *.rabl setf ruby
au BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
au BufRead,BufNewFile *.vue syntax sync fromstart
au FileType vue syntax sync fromstart

" ------ SETTERS ------
set number
set cindent
set autoindent
set laststatus=2

set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set pastetoggle=<F1>
set statusline+=%#warningmsg#
set statusline+=%*

syntax on
set hidden
set guicursor=i:block

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
" Linter configuration
let g:ale_linters = {
  \'javascript': ['eslint'],
\}

" TODO: Add linting function that does : '<,'>s/( /(/g : '<,'>s/ )/)/g :
" '<,'>s/\t/  /g : s/this\./view./g : s/"/'/g : etc  
"
"  ------------------------------------------------------------------------------------------------------ 
" COC VIM 
"  ------------------------------------------------------------------------------------------------------ 

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


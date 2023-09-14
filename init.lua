-- Normally we use vim-extensions. If you want true vi-compatibilitylen*( )
--
vim.o.backspace = '2'      -- more powerful backspacing
-- Don't write backup file if vim is being called by "crontab -e"
vim.cmd([[au BufWrite /private/tmp/crontab.* set nowritebackup]])
-- Don't write backup file if vim is being called by "chpass"
vim.cmd([[au BufWrite /private/etc/pw.* set nowritebackup]])

-- Execute pathogen#infect()
vim.fn['pathogen#infect']()

-- Enable filetype plugin and indent
vim.cmd([[filetype plugin indent on]])

-- Set background to dark
vim.o.background = 'dark'

-- Setting Your Color Scheme
vim.g.my_color_scheme = 'backpack'
vim.g.italicize_comments = 1
vim.g.backpack_contrast_dark = "medium" -- soft hard medium
vim.g.backpack_contrast_light = "medium" -- soft hard medium
vim.g.backpack_italic = 1
vim.g.initial_background = vim.o.background
vim.cmd [[colorscheme backpack]]

vim.g.lightline = {
  colorscheme = vim.g.my_color_scheme,
  active = {
    left = { { 'mode', 'paste' }, { 'readonly', 'filename', 'modified' } },
  },
  tabline = {
    left = { { 'buffers' } },
    right = { { 'close' } },
  },
  component_expand = { buffers = 'lightline#bufferline#buffers' },
  component_type = { buffers = 'tabsel' },
  separator = { left = "", right = "" },
}

vim.g.lightline_bufferline_show_number = 1
vim.g.indentLine_char = '|'

if vim.fn.has('termguicolors') == 1 then
  vim.o.termguicolors = true
  vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
  vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
end
-- Define custom functions

-- Print a console.log() for each variable stored in g register
function PrintJavascriptConsoleLogs()
  local variables_for_logging = vim.split(vim.fn.getreg('a'), " ,, ")
  for _, variable in ipairs(variables_for_logging) do
    if string.len(variable) > 0 then
      vim.cmd("execute \"normal! ccconsole.log('" .. variable .. "\\', " .. variable .. ");\\n\"")
    end
  end
  vim.fn.setreg("a", '')
end

-- Open the Tig Git terminal
function GitLoad()
  vim.cmd("terminal tig")
  vim.fn.startinsert()
  vim.fn.feedkeys('s')
end

-- Reload LightLine
function ReloadLightLine()
  local source_file = "~/.vim/bundle/" .. vim.g.my_color_scheme .. "/autoload/lightline/colorscheme/" .. vim.g.my_color_scheme .. ".vim"
  local colors_source_file = "~/.vim/bundle/" .. vim.g.my_color_scheme .. "/colors/" .. vim.g.my_color_scheme .. ".vim"
  vim.cmd("execute 'source ' .. '~/.config/nvim/bundle/' .. g:my_color_scheme .. '/autoload/lightline/colorscheme/' .. g:my_color_scheme .. '.vim' | call lightline#colorscheme() | call lightline#update()")
end

-- Wait 15 minutes and then open a file
function WaitThenOpenFile()
  vim.fn.sleep(900000)  -- 15 minutes in milliseconds
  vim.cmd("edit " .. vim.fn.getreg('+'))
end

-- Reset Git with Tig
function TigReset()
  vim.cmd("Git reset")
  vim.cmd("call feedkeys('R')")
end



-- Open the Nerd Tree file browser
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true })
-- Find and replace key mapping
vim.api.nvim_set_keymap('x', 'R', ':"<C-U>s/" . getreg("/")."/"<CR>', { expr = true })
vim.api.nvim_set_keymap('x', '*', '"<Plug>(scapegoat_star_register)y:', { noremap = true, silent = true })
-- Git terminal stuff
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-c>', '<Cmd>Git commit <CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-a>', '<Cmd>Git commit --amend <CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-r>', '<Cmd> call TigReset() <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<C-e>', ':<C-U>call append(".", getline("."))<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>:echon ""<CR>', { noremap = true })

-- For Console logs
--
-- For Visual mode (xnoremap)
vim.api.nvim_set_keymap('x', '<C-m>', [["dy :lua vim.fn.setreg('a', vim.fn.getreg('d') .. ' ,, ' .. vim.fn.getreg('a'))<CR>]], { noremap = true, silent = true })
-- For Normal mode (nnoremap)
vim.api.nvim_set_keymap('n', '<C-m>', [["dyiw :lua vim.fn.setreg('a', vim.fn.getreg('d') .. ' ,, ' .. vim.fn.getreg('a'))<CR>]], { noremap = true, silent = true })

-- Copy to any register
vim.api.nvim_set_keymap('n', 'Y', '"*yy', { noremap = true })
vim.api.nvim_set_keymap('v', 'Y', '"*y<Esc>', { noremap = true })
-- Force quit the buffer (tab)
vim.api.nvim_set_keymap('c', 'qq', ':bw!<CR>', { noremap = true })
-- Quit the buffer (tab)
vim.api.nvim_set_keymap('n', 'tc', ':bw<CR>', { noremap = true })
-- Force quit the buffer (tab)
vim.api.nvim_set_keymap('n', 'tcc', ':bw!<CR>', { noremap = true })
-- Previous buffer (tab)
vim.api.nvim_set_keymap('n', 'tr', ':bp<CR>', { noremap = true })
-- Next buffer (tab)
vim.api.nvim_set_keymap('n', 'ty', ':bn<CR>', { noremap = true })
-- List buffers (tab)
vim.api.nvim_set_keymap('n', 'tt', ':ls<CR>', { noremap = true })

-- Comment
vim.api.nvim_set_keymap('v', 'oo', '<plug>NERDCommenterToggle', { noremap = true })
vim.api.nvim_set_keymap('n', 'oo', '<plug>NERDCommenterToggle', { noremap = true })

-- Define custom commands
-- Remove extra spaces at end of the lines
vim.api.nvim_set_keymap('i', 'CONS', '<Esc>:lua PrintJavascriptConsoleLogs()<CR>', { noremap = true, silent = true })
vim.cmd([[command! Clean :%s/\s\+$//e]])
vim.cmd([[command! GL :lua GitLoad()]])
vim.cmd([[command! CONS :lua PrintJavascriptConsoleLogs()]])
vim.cmd([[command! CL :lua vim.fn.setreg("a", '')]])
vim.cmd([[command! BD :set background=dark]])
vim.cmd([[command! BL :set background=light]])

-- Go to next linter error
vim.cmd([[command! AN ALENext]])
-- Go to previous linter error
vim.cmd([[command! AP ALEPrevious]])
-- Redraw the vim screen
vim.cmd([[command! RF syntax sync fromstart]])
-- Reload vimrc and lightline theme
vim.cmd([[command! RL source $MYVIMRC | lua ReloadLightLine()]])

function ReloadConfig()
  local luacache = (_G.__luacache or {}).cache
  -- TODO unload commands, mappings + ?symbols?
  for pkg, _ in pairs(package.loaded) do
    if pkg:match '^my_.+'
    then
      print(pkg)
      package.loaded[pkg] = nil
      if luacache then
        lucache[pkg] = nil
      end
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify('Config reloaded!', vim.log.levels.INFO)
end
-- Convert from snake_case to camelCase
vim.cmd([[command! -range CC <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])
vim.cmd([[command! -range CamelCase <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])

-- Define auto commands

vim.cmd([[autocmd OptionSet background
       \ execute 'source' '~/.config/nvim/bundle/backpack/autoload/lightline/colorscheme/backpack.vim'
       \ | call lightline#colorscheme() | call lightline#update()]])
vim.cmd([[autocmd TermEnter * execute "set background=dark | call ReloadLightLine()"]])
vim.cmd([[autocmd TermOpen * execute "set background=dark | call ReloadLightLine()"]])
vim.cmd([[autocmd TermEnter * execute "highlight LineNr guifg=" .. g:background_color[0]"]])
vim.cmd([[autocmd TermEnter * execute "highlight LineNr guibg=" .. g:background_color[0]"]])
vim.cmd([[autocmd TermEnter * execute "highlight CursorLineNr guifg=" .. g:background_color[0]"]])
vim.cmd([[autocmd TermLeave * execute "highlight LineNr guifg=" .. g:line_nr[0]"]])
vim.cmd([[autocmd TermLeave * execute "highlight CursorLineNr guifg=" .. g:line_nr[0]"]])
vim.cmd([[autocmd TermLeave * execute "set background=" .. g:initial_background .. " | call ReloadLightLine()"]])
vim.cmd([[autocmd BufNewFile,BufRead *.jst set filetype=html]])
vim.cmd([[autocmd BufRead,BufNewFile *.rabl setf ruby]])
vim.cmd([[autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css]])
vim.cmd([[autocmd BufRead,BufNewFile *.vue syntax sync fromstart]])

-- ------ SETTERS ------
vim.o.number = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.laststatus = 2

vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.pastetoggle = "<F1"
vim.o.statusline = "%#warningmsg# %*"
vim.cmd("syntax on")
vim.o.hidden = true
vim.o.guicursor = "i:block"
vim.o.t_Co = 256
vim.o.showtabline = 2

-- Define an autocmd to call lightline#update() on BufWritePost, TextChanged, and TextChangedI events
-- vim.cmd("autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()")

vim.o.cursorline = true

-- Linter configuration
vim.g.ale_linters = {
  javascript = {"eslint"},
}

-- -------------------------------------------------------------------
-- --------------------COC VIM ---------------------------------------
-- -------------------------------------------------------------------
--
--
--- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

local vim = vim

local map = vim.api.nvim_set_keymap

-- Don't write backup file if vim is being called by "crontab -e"
vim.cmd([[au BufWrite /private/tmp/crontab.* set nowritebackup]])
-- Don't write backup file if vim is being called by "chpass"
vim.cmd([[au BufWrite /private/etc/pw.* set nowritebackup]])

vim.g.signify_sign_add = '┃'
vim.g.signify_sign_change = '┃'
vim.g.signify_sign_delete = '•'
vim.g.signify_sign_show_count = 0
vim.g.context_highlight_tag = '<hide>'
vim.g.context_max_height = 3


vim.cmd("syntax on")

require("config.lazy")
require("helpers")
require("options")

 -- Language Server Config Setups
local lspconfig = require('lspconfig')

lspconfig.volar.setup({
   init_options = {
     --typescript = {
     --  tsdk = "/Users/dirtplantman/.nvm/versions/node/v22.14.0/lib/node_modules/typescript/lib",
     --}
   },
})

lspconfig.pyright.setup{}
lspconfig.java_language_server.setup{}
lspconfig.html.setup{}

lspconfig.ltex.setup({
  -- on_attach = on_attach,
  cmd = { "ltex-ls" },
  filetypes = { "markdown", "text" },
  flags = { debounce_text_changes = 300 },
})

vim.api.nvim_create_autocmd('LspAttach', {
     desc = 'LSP Actions',
     callback = function(args)
         vim.keymap.set('n', 'K', vim.lsp.buf.hover, {noremap = true, silent = true})
         vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {noremap = true, silent = true})
     end,
 })


-- Enable filetype plugin and indent
vim.cmd([[filetype plugin indent on]])

vim.g.my_color_scheme = 'backpack'

vim.cmd('colorscheme ' .. vim.g.my_color_scheme)


-- Get highlight group (color group) for
-- item under the cursor to allow for setting syntax highlighting
map('n', '<C-h>', [[:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>]], { noremap = true })

-- Open the Neo Tree file browser
map('n', '~', '%', { noremap = true })
map('x', '~', '%', { noremap = true })
map('n', '|', ':Neotree filesystem toggle left<CR><CR>', {
 noremap = true,
 silent = true
})

map('n', '_', ':q! <CR>', { noremap = true })
-- Find and replace key mapping
map('x', 'R', [[":s/" .. getreg('/') .."/"]], { expr = true, noremap = true })
map('x', '*', [["wy :lua vim.fn.setreg('/', vim.fn.getreg('w'))<CR>]], { noremap = true, silent = true })
-- Git terminal stuff
map('t', '<Esc><Esc>', '<C-\\><C-n> <Cmd> close <CR>', { noremap = true, silent = true })
map('t', '<C-c>', '<Cmd>Git commit <CR>', { noremap = true })
map('t', '<C-a>', '<Cmd>Git commit --amend <CR>', { noremap = true })
map('t', '<C-r>', '<Cmd>lua TigReset() <CR>', { noremap = true })
map('t', '<C-e>', '<Esc><Esc><Cmd> echo nvim_get_current_line() lua WaitThenOpenFile() <CR>', { noremap = true })
map('t', '<C-e>', '<Cmd>call feedkeys("E") | lua WaitThenOpenFile(true) <CR>', { noremap = true })
--
map('t', '<C-e>', 'E <Cmd>lua WaitThenOpenFile(true) <CR>', { noremap = true })
map('n', '<C-e>', ':<C-U>call append(".", getline("."))<CR>', { noremap = true })
map('n', '<C-e>', '<Cmd>lua WaitThenOpenFile(false) <CR>', { noremap = true })
map('n', '<C-e>', 'E <Cmd>lua WaitThenOpenFile(true) <CR>', { noremap = true })

map('i', '<C-r>', "<Cmd> lua SetPaste() <CR>", { noremap = true, silent = true })

map('n', '<C-e>', 'E <Cmd>lua WaitThenOpenFile(true) <CR>', { noremap = true })
map('n', '<Esc>', '<Cmd>noh |  echon "" | lua CloseWindow() <CR>', { noremap = true })
-- map('n', '<Esc><Esc>', '<Cmd>lua CloseWindow()<CR>', { noremap = true, silent = true })
--- https://github.com/jhawthorn/fzy/pull/116#issuecomment-538708329
vim.keymap.set('n', '˙', function () require'fzy'.History() end)
vim.keymap.set('n', '†', function () require'fzy'.Oldfiles() end)
vim.keymap.set('n', 'ß', function () require'fzy'.Buffers() end)
vim.keymap.set('n', '®', function () require'fzy'.FindFile() end)
vim.cmd([[command! -nargs=1 -complete=file S lua require'fzy'.Search(<f-args>)]])
map('n', 'ff', [[:lua require"fzy".FindFile()<CR>]], { noremap = true, silent = true })

-- For Console logs
vim.fn.setreg("a", '')
vim.fn.setreg("d", '')
-- For Visual mode (xnoremap)
map('x', '<C-m>', [["dy :lua vim.fn.setreg('a', vim.fn.getreg('d') .. ' ,, ' .. vim.fn.getreg('a'))<CR>]], { noremap = true, silent = true })
-- For Normal mode (nnoremap)
map('n', '<C-m>', [["dyiw :lua vim.fn.setreg('a', vim.fn.getreg('d') .. ' ,, ' .. vim.fn.getreg('a'))<CR>]], { noremap = true, silent = true })

-- Copy to any register
map('n', 'Y', '"*yy', { noremap = true })
map('v', 'Y', '"*y<Esc>', { noremap = true })
-- Force quit the buffer (tab)
map('c', 'qq', ':bw!<CR>', { noremap = true })
-- Quit the buffer (tab)
map('n', 'tc', ':bw<CR>', { noremap = true })
-- Force quit the buffer (tab)
map('n', 'tcc', ':bw!<CR>', { noremap = true })
--
-- Comment
map('v', 'gc', '<plug>NERDCommenterToggle', { noremap = true })
map('n', 'gc', '<plug>NERDCommenterToggle', { noremap = true })

-- Define custom commands
-- Remove extra spaces at end of the lines
map('i', 'CONS', '<Esc>:lua PrintJavascriptConsoleLogs()<CR>', { noremap = true, silent = true })
vim.cmd([[command! Clean :%s/\s\+$//e]])
vim.cmd([[command! GL :lua GitLoad()]])
vim.cmd([[command! GB :lua GitBlame()]])
vim.cmd([[command! CONS :lua PrintJavascriptConsoleLogs()]])
vim.cmd([[command! CL :lua vim.fn.setreg("a", '')]])
-- vim.cmd([[command! BD :set background=dark]])
-- vim.cmd([[command! BL :set background=light]])

-- Go to next linter error
vim.cmd([[command! AN call CocAction('diagnosticNext')]])
-- Go to previous linter error
vim.cmd([[command! AP call CocAction('diagnosticPrevious')]])
-- Redraw the vim screen
vim.cmd([[command! RF syntax sync fromstart]])
-- Reload vimrc and lightline theme
vim.cmd([[command! RL source $MYVIMRC | lua ReloadLightLine()]])

vim.g.lightline_bufferline_show_number = 1
-- Convert from snake_case to camelCase
vim.cmd([[command! -range CC <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])
vim.cmd([[command! -range CamelCase <line1>,<line2>s/\(_\)\(.\)/\u\2/g]])

-- Define auto commands

--vim.cmd([[autocmd OptionSet background
--       \ execute 'source' '~/.config/nvim/bundle/backpack/autoload/lightline/colorscheme/backpack.vim'
--       \ | call lightline#colorscheme() | call lightline#update()]])
-- vim.cmd([[autocmd TermEnter * execute "set background=dark | lua ReloadLightLine()"]])
-- vim.cmd([[autocmd TermOpen * execute "set background=dark | lua ReloadLightLine()"]])
vim.cmd([[autocmd TermEnter * execute "highlight LineNr guifg=" .. g:background_color[0] ]])
vim.cmd([[autocmd TermEnter * execute "highlight LineNr guibg=" .. g:background_color[0] ]])
vim.cmd([[autocmd TermEnter * execute "highlight CursorLineNr guifg=" .. g:background_color[0] ]])
vim.cmd([[autocmd TermLeave * execute "highlight LineNr guifg=" .. g:line_nr[0] ]])
vim.cmd([[autocmd TermLeave * execute "highlight CursorLineNr guifg=" .. g:line_nr[0] ]])
vim.cmd([[autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css || TSBufDisable highlight]])
-- vim.cmd([[autocmd TermLeave * execute "set background=" .. g:initial_background .. " | lua ReloadLightLine()"]])
-- vim.cmd([[autocmd BufNewFile,BufRead *.jst set filetype=html]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.rabl setf ruby]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.mjs setlocal filetype=javascript || TSBufDisable highlight]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.js TSBufDisable highlight]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.scss TSBufDisable highlight]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.css TSBufDisable highlight]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.vim TSBufDisable highlight]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.* echo "test"]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.vue syntax sync fromstart]])

vim.cmd([[autocmd BufRead,BufNewFile * execute "lua BufferOrderByBufferNumberSafe()"]])


local keyset = vim.keymap.set
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


keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent lua CocActionAsyncSafe('highlight')",
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
    command = "call CocActionAsyncSafe('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
opts = { silent = true, nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>a", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- keyset('n', '<D-h', ':bn<CR>', { noremap = true })
-- -- Previous buffer (tab)
-- keyset('n', '<D-l', ':bp<CR>', { noremap = true })

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
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

-- For window borders

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "single"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "single"
  }
)

vim.cmd [[nnoremap <buffer><silent> <C-space> :lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>]]
vim.cmd [[nnoremap <buffer><silent> ]g :lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>]]
vim.cmd [[nnoremap <buffer><silent> [g :lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>]]

-- Do not forget to use the on_attach function
-- To instead override globally
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

local sign_define = vim.fn.sign_define
sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

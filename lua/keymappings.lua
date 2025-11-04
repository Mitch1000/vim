local vim = vim
local keyset = vim.keymap.set
-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

--keyset('n', '<C-t>', function () require'fzy'.History() end)
--keyset('n', '<C-e>', function () require'fzy'.Oldfiles() end)
local telescope_exists, builtin = pcall(require, 'telescope.builtin')
if telescope_exists then
  local function find_files()
    builtin.find_files({ cwd = vim.cmd([[pwd]]) })
  end
  keyset('n', '<C-e>', find_files, { desc = 'Telescope find files' })
  keyset('n', '<C-t>', builtin.buffers, { desc = 'Telescope find buffers' })
  keyset('n', '<C-j>', builtin.oldfiles, { desc = 'Telescope find histoary' })
end
-- keyset('n', '<C-s>', function () require'fzy'.Buffers() end)
-- keyset('n', '<C-r>', function () require'fzy'.FindFile() end)
--
local coc_exists = pcall(vim.fn['coc#pum#visible'])

if coc_exists then
  keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
  keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
  -- Make <CR> to accept selected completion item or notify coc.nvim to format
  -- <C-g>u breaks current undo, please make your own choice
  keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
end

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
-- keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
-- Source - https://stackoverflow.com/questions/73858788/neovim-goto-definition
-- Posted by Brotify Force
-- Retrieved 2025-11-04, License - CC-BY-SA 4.0
keyset("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
keyset("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local codeActionOpts = { silent = true, nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", codeActionOpts)
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-selected)", codeActionOpts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>a", "<Plug>(coc-codeaction-cursor)", codeActionOpts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", codeActionOpts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", codeActionOpts)

-- keyset('n', '<D-h', ':bn<CR>', { noremap = true })
-- -- Previous buffer (tab)
-- keyset('n', '<D-l', ':bp<CR>', { noremap = true })

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", codeActionOpts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", codeActionOpts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", codeActionOpts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", codeActionOpts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", codeActionOpts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", codeActionOpts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", codeActionOpts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", codeActionOpts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", codeActionOpts)

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local simpleOpts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", simpleOpts)
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", simpleOpts)
-- Show commands
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", simpleOpts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", simpleOpts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", simpleOpts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", simpleOpts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", simpleOpts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", simpleOpts)

local map = vim.api.nvim_set_keymap

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
--map('n', '<C-e>', ':<C-U>call append(".", getline("."))<CR>', { noremap = true })
--map('n', '<C-e>', '<Cmd>lua WaitThenOpenFile(false) <CR>', { noremap = true })
--map('n', '<C-e>', 'E <Cmd>lua WaitThenOpenFile(true) <CR>', { noremap = true })

map('i', '<C-r>', "<Cmd> lua SetPaste() <CR>", { noremap = true, silent = true })

map('n', '<Esc>', '<Cmd>noh |  echon "" | lua CloseWindow() <CR>', { noremap = true })

map('n', 'ff', [[:lua require"fzy".FindFile()<CR>]], { noremap = true, silent = true })

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


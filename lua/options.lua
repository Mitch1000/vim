local vim = vim
if vim.fn.has('termguicolors') == 1 then
  vim.o.termguicolors = true
end

vim.o.backspace = '2'      -- more powerful backspacing
-- ------ SETTERS ------
vim.g.indentLine_char = '|'
vim.g.markdown_folding = 1
-- vim.g.vim_jsx_pretty_colorful_config = 1
-- vim.g.vim_jsx_pretty_highlight_close_tag = 1
-- vim.g.vim_jsx_pretty_disable_js = 1
vim.o.number = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.laststatus = 2
-- Popup menu at the bottom of the page.
vim.o.pumblend = 4
vim.o.pumheight = 15
vim.o.signcolumn = 'yes'
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.statusline = "%#warningmsg# %*"
vim.o.hidden = true
vim.o.guicursor = "i:block"
vim.o.showtabline = 2
vim.o.cursorline = true

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

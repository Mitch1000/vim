-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- return {
--   -- General plugins
--   { 'vim-ruby/vim-ruby' },
--   { 'tpope/vim-rails' },
--   { 'tpope/vim-fugitive' },
--   { 'nvim-treesitter/nvim-treesitter' },
--   { 'wellle/context.vim' },
--   { 'Shatur/neovim-ayu' },
--   { 'mitch1000/backpack' },
--   { 'neovim/nvim-lspconfig' },
--   { 'mhinz/vim-signify' },
--   { 'pangloss/vim-javascript' },
--   { 'darfink/vim-plist' },
--   { 'Raimondi/delimitMate' },
--   { 'joshdick/onedark.vim' },
--   { 'lunacookies/vim-colors-xcode' },
--   { 'romgrk/barbar.nvim' },
--   { 'preservim/nerdcommenter' },
--   { 'nvim-tree/nvim-web-devicons' },
-- 
--   -- Plugins with configuration
--   {
--     "loctvl842/monokai-pro.nvim",
--     config = function()
--       require("monokai-pro").setup()
--     end
--   },
-- 
--   {
--     "nvimdev/guard.nvim",
--     dependencies = { 'nvimdev/guard-collection' },
--     event = "BufReadPre",
--   },
-- 
--   {
--     'nvim-lualine/lualine.nvim',
--     config = function()
--       -- Add your lualine config here if needed
--     end
--   },
-- 
--   {
--     "nvim-neo-tree/neo-tree.nvim",
--     branch = "v3.x",
--     dependencies = {
--       "mitch1000/backpack",
--       "nvim-lua/plenary.nvim",
--       "MunifTanjim/nui.nvim",
--     },
--     config = function()
--       -- Add your neo-tree config here if needed
--     end
--   },
-- 
--   -- CoC needs special handling in Lazy
--   {
--     'neoclide/coc.nvim',
--     branch = 'release',
--     build = 'yarn install --frozen-lockfile',
--     init = function()
--       -- CoC specific initialization if needed
--     end
--   }
-- }

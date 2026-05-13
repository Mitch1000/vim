 -- Language Server Config Setups
local vim = vim
local lspconfig = vim.lsp.config
local nvim_lsp = require 'lspconfig'

local vue_language_server_path = "/Users/mog/.nvm/versions/node/v22.17.0/bin/vue-language-server"
local ts_language_server_path = "/Users/mog/.nvm/versions/node/v22.17.0/bin/typescript-language-server"
local ts_lib_path = "/Users/mog/.nvm/versions/node/v22.17.0/lib/node_modules/typescript-language-server/lib"

lspconfig.ts_ls = {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  --init_options = {

  --  --plugins = {
  --  --  {
  --  --    name = "@vue/typescript-plugin",
  --  --    location = vue_language_server_path,
  --  --    languages = { "vue" },
  --  --  },
  --  --},
  --},
}

lspconfig.vue_ls = {
  cmd = vue_language_server_path,
  init_options = {
   vue = {
     hybridMode = false,
   },
   -- NOTE: This might not be needed. Uncomment if you encounter issues.

   --typescript = {
   --  tsdk = ts_lib_path,
   --},
  },
}

lspconfig.rubocop = {
--  cmd = { "bundle", "exec", "rubocop", "--lsp" },
--  root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git", "."),
}

vim.lsp.enable('ts_ls')
vim.lsp.enable('vue_ls')

local language_servers = {
  "java_language_server",
  "pyright",
  "html",
  "sqls",
  "rubocop",
  "ccls",
  "rust_analyzer",
  "solargraph",
  "ts_query_ls",
  "tailwindcss",
  "cssls",
  "eslint",
}

for _index, value in ipairs(language_servers) do
  lspconfig[value] = {}
  vim.lsp.enable(value)
end

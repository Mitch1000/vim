 -- Language Server Config Setups
local status, lspconfig = pcall(require, 'lspconfig')
if not status then
   return
end

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

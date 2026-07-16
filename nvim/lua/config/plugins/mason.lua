require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "lua_ls",
    "bashls",
    "pyright",
  },
  automatic_installation = true,
  handlers = {
    function(_)
      -- Servers are configured via vim.lsp.config() (Neovim built-in)
    end,
  },
})

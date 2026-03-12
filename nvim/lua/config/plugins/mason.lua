require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",         -- C / C++
    "lua_ls",         -- Lua
    "bashls",         -- Bash
    "pyright",        -- Python (лучше pylint + ruff, но pyright — быстро и точно)
    -- опционально: "ruff_lsp" для линтинга/форматирования Python
  },
  automatic_installation = true,
})

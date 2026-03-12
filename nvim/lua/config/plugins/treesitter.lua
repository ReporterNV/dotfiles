require("nvim-treesitter").setup({
  ensure_installed = { "c", "cpp", "lua", "vim", "python", "javascript", "typescript", "rust" },
  highlight = { enable = true },
  indent = { enable = true },
})

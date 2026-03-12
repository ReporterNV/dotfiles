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

-- Setup lazy.nvim
require("lazy").setup({
	--{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("config.plugins.telescope") end },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("config.plugins.telescope") end },

	-- Colorschemes
	{ "Mofiqul/dracula.nvim" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "tandy1229/deus.nvim", lazy = false, priority = 1000 },
	{ "srcery-colors/srcery-vim", as = "srcery" },

	{ "norcalli/nvim-colorizer.lua", config = function() require("config.plugins.colorizer") end },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function() require("config.plugins.treesitter") end,
	},
	-- Show context if block is big
	{ "nvim-treesitter/nvim-treesitter-context", dependencies = { "nvim-treesitter/nvim-treesitter" } },

	{ "mbbill/undotree", config = function() require("config.plugins.undotree") end },

	-- LSP stack (mason + lspconfig)
	{ "williamboman/mason.nvim", config = true },
	{ "williamboman/mason-lspconfig.nvim", config = function() require("config.plugins.mason") end },
	{ "neovim/nvim-lspconfig", config = function() require("config.plugins.lsp") end },

	-- Completion
	{ "hrsh7th/nvim-cmp", config = function() require("config.plugins.cmp") end },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },

	--{ "github/copilot.vim" },

		checker = {
		enabled = false,
	},
})

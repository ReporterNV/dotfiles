vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'nvim-tree/nvim-tree.lua'
	-- Colorschemes
	use 'dracula/vim'
	use 'machakann/vim-colorscheme-imas'
	use {'srcery-colors/srcery-vim', as = 'srcery'}

	use 'norcalli/nvim-colorizer.lua'
	use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use ('nvim-treesitter/nvim-treesitter-context')
	use 'mbbill/undotree'

	--use 'neovim/nvim-lspconfig'
	use ({
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	})
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
	--mason
	--lsp-cmp
end)

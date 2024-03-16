vim.cmd([[
set number
set relativenumber
set clipboard+=unnamedplus
set mouse=a
syntax enable
syntax on
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set list
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ 
set termguicolors
colorscheme dracula
]])


vim.o.ignorecase = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_set_keymap('n', '<C-c>', '"+y', {noremap = true})
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', {noremap = true})


   local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

   if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
       vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
       vim.cmd [[packadd packer.nvim]]
   end

  -- Initialize plugin manager
require('packer').startup(function()
	-- Specify your plugins here
	use 'vim-airline/vim-airline'
	use 'dracula/vim'
	use 'nvim-tree/nvim-tree.lua'
	use 'ervandew/supertab'
end)


require("nvim-tree").setup()

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  ---
  on_attach = my_on_attach,
  ---
}

vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', {noremap = true, silent = true})


require("main")
--require'lspconfig'.lua_ls.setup{}
--require'lspconfig'.ccls.setup{}

vim.cmd([[
set number
set relativenumber
set clipboard+=unnamedplus
set mouse=a
syntax enable
syntax on
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
colorscheme dracula
set list
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ 
set termguicolors
set background=dark
set noswapfile
]])


--[[
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--]]
--
vim.keymap.set('n', '<C-c>', '"+y', {noremap = true})
vim.keymap.set('v', '<C-c>', '"+y', {noremap = true})

vim.keymap.set('n', '<C-v>', '"+p', {noremap = true})
vim.keymap.set('v', '<C-v>', '"+p', {noremap = true})


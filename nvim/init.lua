-- Основные настройки
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.list = true
vim.opt.listchars = { trail = '·', precedes = '«', extends = '»', eol = '↲', tab = '▸ ' }

vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

vim.cmd.colorscheme('catppuccin')
--vim.cmd.colorscheme('deus')

-- netrw
vim.g.netrw_liststyle    = 3
vim.g.netrw_winsize      = 25
vim.g.netrw_preview      = 1
vim.g.netrw_hide         = 0


vim.keymap.set('n', '<leader>e', ':Explore<CR>',   { desc = "Open netrw (Explore)" })
vim.keymap.set('n', '<leader>E', ':Vex<CR>', { desc = "Open netrw left vertical" })
vim.keymap.set('n', '<leader>se', ':Sex<CR>',      { desc = "Open netrw horizontal split" })

-- Прозрачный фон
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.keymap.set('n', '<C-n>', ':tabnew<CR>', { desc = 'New tab' })

vim.keymap.set({ 'n', 'v' }, '<C-c>', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<C-v>', '"+p', { desc = 'Paste from system clipboard' })

-- Copilot
--[[
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99
vim.opt.foldenable = false
--]]

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.opt.exrc = true
vim.opt.secure = true

require("config.lazy")
vim.g.copilot_enabled = false


set number 
set relativenumber
"filetype plugin indent on
set mouse=a "Mouse support for windows
syntax enable
syntax on
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set list
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ "Отображние табов и переноса строки


"=====================================
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'lervag/vimtex'
Plug 'shime/vim-livedown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()
"=====================================

nmap <C-n> :Vex<CR>


colorscheme solas

"=====================================
"FZF
nmap ; :Buffers<CR>
nmap ","t :Files<CR>
nmap <Leader>r :Tags<CR>
"=====================================
"VIMTEX
let g:tex_flavor = 'latex' "Уточняем какой Тех
let g:vimtex_view_method = 'zathura'
"=====================================
"AIRLINE
let g:airline_powerline_fonts = 1 "Включить поддержку Powerline шрифтов
let g:airline#extensions#keymap#enabled = 0 "Не показывать текущий маппинг
let g:airline_section_z = "\ue0a1:%l/%L Col:%c" "Кастомная графа положения курсора
let g:Powerline_symbols='unicode' "Поддержка unicode
let g:airline#extensions#xkblayout#enabled = 0 "Про это позже расскажу
"=====================================

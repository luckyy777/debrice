let mapleader =","
syntax on
set termguicolors

hi CursorLineNr term=bold ctermfg=2 gui=bold guifg=terminal_color_2

set cursorline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" groff stuff
map <leader>c :w! \| !sh '/home/ollie/.local/bin/compiler.sh' "<c-r>%"<CR>
map <leader>w :w! \| !bash '/home/ollie/.local/bin/wordcount.sh' <enter>

colorscheme rosebox

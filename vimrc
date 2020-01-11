set nocompatible
filetype off

" install: 
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" vim_run:
" :PluginInstall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

call vundle#end()
filetype plugin indent on

Plugin 'scrooloose/syntastic'
let g:syntastic_python_checkers = ['pylint']

Plugin 'davidhalter/jedi-vim'
autocmd FileType python setlocal completeopt-=preview

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

"gnupg
Plugin 'jamessan/vim-gnupg'

set encoding=utf-8

" Podświetlanie składni i numerowanie wierszy - mam nadzieję, że nikt nie
" będzie musiał tego dopisywać u siebie. :D
syntax on
set number
nnoremap <F2> :set nonumber!<CR>

" Disable auto comment insertions
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Tab jako 4 spacje
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

" 2 spacje dla yaml
autocmd Filetype yml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Wyświetlanie zbędnych białych znaków - według mnie must-have
" Przy tych ustawieniach Vim będzie podświetlał tylko zbędne białe znaki
" na końcu linii oraz białe znaki w pustych wierszach.
" Symbole można zamienić na dowolne, ale najlepiej sprawdzą się jakieś
" niestandardowe z Unicode.
set list
set listchars=trail:⋅,nbsp:⋅,tab:▷⋅

" Ustawienia wyszukiwania - inteligentne wykrywanie wielkości liter,
"  podświetlanie wyników, szukanie w trakcie pisania
set ignorecase smartcase
set hlsearch
set incsearch

" Podświetlenie aktywnej linijki (kolor można sobie dobrać)
"highlight CursorLine cterm=NONE ctermbg=gray guibg=gray8
"set cursorline

" Python zachęca do trzymania się wersów o długości do 80 kolumn
" Zamiast podświetlenia wszystkich pustych znaków na 80 kolumnie,
"      podświetl znak dopiero po przekroczeniu tego limitu.
"      highlight ColorColumn guibg=gray2
"call matchadd('ColorColumn', '\%81v', 100)

" j/k będą przechodzić przez zawijane linie tekstu.
nnoremap j gj
nnoremap k gk

" disable mouse automatic visual mode
set mouse-=a



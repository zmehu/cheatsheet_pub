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

" Syntax highlighting, numering, F2 toggle numering
syntax on
set number
nnoremap <F2> :set nonumber!<CR>

" Disable auto comment insertions
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Use space when Tab
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

" yaml fix 2 space not 4
autocmd Filetype yml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" show whitespaces at end
set list
set listchars=trail:⋅,nbsp:⋅,tab:▷⋅

" search improve
set ignorecase smartcase
set hlsearch
set incsearch

" highlight CursorLine cterm=NONE ctermbg=gray guibg=gray8
"set cursorline

" Python show more than 80 chars in line
"call matchadd('ColorColumn', '\%81v', 100)

" j/k move up/down
nnoremap j gj
nnoremap k gk

" disable mouse automatic visual mode
set mouse-=a



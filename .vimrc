set nocompatible

"===== vim-plug ====="

" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc 
endif

" vim-plug directory
call plug#begin('~/.vim/plugged')

" vim-plug list of plugins
Plug 'vim-airline/vim-airline'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
Plug 'pboettch/vim-cmake-syntax'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" vim-plug end of list
call plug#end()

" Splits
set splitbelow
set splitright

" Line numbering
set number

" Configure indentation and column line marker
" Python, C++
au BufNewFile,BufRead *.py,*.h,*.?pp,*.c,*.cc
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |
	\ set colorcolumn=80
" Spell checking
" Markdown (vim-markdown plugin)
au FileType markdown setlocal nospell


" Additional shortcuts
map <C-n> :NERDTreeToggle<CR>

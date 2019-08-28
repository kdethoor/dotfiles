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
Plug 'mrk21/yaml-vim', {'for': 'yaml'}

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
	\ setlocal tabstop=4 |
	\ setlocal softtabstop=4 |
	\ setlocal shiftwidth=4 |
	\ setlocal textwidth=79 |
	\ setlocal expandtab |
	\ setlocal autoindent |
	\ setlocal fileformat=unix |
	\ setlocal colorcolumn=80
" YAML (https://lornajane.net/posts/2018/vim-settings-for-working-with-yaml)
au BufNewFile,BufRead *.yaml,*.yml
	\ set filetype=yaml |
	\ set foldmethod=indent	|
	\ normal zR
au FileType yaml
	\ setlocal tabstop=2 |
	\ setlocal softtabstop=2 |
	\ setlocal shiftwidth=2 |
	\ setlocal expandtab
" Spell checking
" Markdown (vim-markdown plugin)
au FileType markdown setlocal nospell


" Additional shortcuts
map <C-n> :NERDTreeToggle<CR>

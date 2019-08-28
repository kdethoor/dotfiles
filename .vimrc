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
Plug 'ambv/black', {'for': 'python'}


" vim-plug end of list
call plug#end()

"===== Splits ====="
set splitbelow
set splitright

"===== Line numbering ====="
set number

"===== File-type-specific indentation, tabs, etc ====="
" Python, C++
au FileType python,cpp
	\ set expandtab |	
	\ set tabstop=4 | 	
	\ set softtabstop=4 | 	
	\ set shiftwidth=4 |	
	\ set autoindent |
	\ set textwidth=79 | 	
	\ set colorcolumn=80	
" Python
au FileType python
	\ setlocal foldmethod=indent |
	\ normal zR
" YAML (https://lornajane.net/posts/2018/vim-settings-for-working-with-yaml)
au BufNewFile,BufRead *.yaml,*.yml
	\ set filetype=yaml |
au FileType yaml
	\ set expandtab |
	\ set tabstop=2 |
	\ set softtabstop=2 |
	\ set shiftwidth=2 |
	\ set autoindent |
	\ set foldmethod=indent |
	\ normal zR

" Spell checking
" Markdown (vim-markdown plugin)
au FileType markdown setlocal nospell

" Additional shortcuts
map <C-n> :NERDTreeToggle<CR>

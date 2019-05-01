set nocompatible
echo $PWD

"===== vim-plug ====="
""" Determine OS for installation
" If Linux, expects .vim/ and .vimrc to be in ~/
" If Windows, expects them to be in the current folder
let uname = substitute(system('uname'), '\n', '', '')
let base_plug_path = '.vim/autoload/plug.vim'
let base_vimrc_path = '.vimrc'
let plug_path = base_plug_path
let vimrc_path = base_vimrc_path
let vimplug_uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

""" Install vim-plug if not present
if empty(plug_path)
    if uname == 'Linux'
        " Adjust paths
        let plug_path = '~/' . plug_path
        let vimrc_path = '~/' . vimrc_path
        silent !curl -fLo plug_path --create-dirs vimplug_uri
    else " Windows
        silent !wget vimplug_uri -O plug_path
    endif
    autocmd VimEnter * PlugInstall --sync | source vimrc_path
endif

" vim-plug directory
call plug#begin('~/.vim/plugged')

" vim-plug list of plugins
Plug 'vim-airline/vim-airline'
Plug 'davidhalter/jedi-vim', {'for': 'python'}

" vim-plug end of list
call plug#end()

" Splits
set splitbelow
set splitright

" Line numbering
set number

" Configure indentation
" Python
au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix


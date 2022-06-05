"===== Vim Plug Setup ====='
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"===== Line numbering ====='
set number

"===== Splits ====='
set splitbelow
set splitright

"===== Plugins ====='
call plug#begin()
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

"===== Plugin setup ====='
" Catppuccin
lua << EOF
require('catppuccin').setup {
}
vim.g.catppuccin_flavour = 'macchiato'
vim.cmd[[colorscheme catppuccin]]
EOF

" nvim-tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

lua << EOF
require('nvim-tree').setup {
}
EOF

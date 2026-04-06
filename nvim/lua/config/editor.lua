-- Leader key
vim.g.mapleader = " "

-- Colors
vim.opt.termguicolors = true

-- Column hint
vim.opt.colorcolumn = "88"

-- Completion
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Fold
vim.opt.foldlevel = 99

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Line numbers
vim.opt.nu = true
vim.opt.rnu = true
vim.g.netrw_bufsettings = "noma nomod rnu nowrap ro nobl"

-- Line wrapping
vim.opt.wrap = false

-- Scrolling
vim.opt.scrolloff = 8

-- Search
vim.opt.incsearch = true

-- Shell
vim.o.shell = "powershell.exe"

-- Spellchecking
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- Swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false


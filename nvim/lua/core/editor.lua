-- Language
vim.cmd("language C.utf8")

-- Leader key
vim.g.mapleader = " "

-- Colors
vim.opt.termguicolors = true

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.smartindent = true

-- Line numbers
vim.opt.nu = true
vim.opt.rnu = true
vim.g.netrw_bufsettings = "noma nomod rnu nowrap ro nobl"

-- Line wrapping
vim.opt.wrap = false

-- Column hint
vim.opt.colorcolumn = "88"

-- Search
vim.opt.incsearch = true

-- Scrolling
vim.opt.scrolloff = 8

-- Swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false

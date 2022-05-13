local set = vim.opt

-- Use space as a the leader key
vim.g.mapleader = ' '

-- Set the behavior of tab
set.autoindent = true
set.smartindent = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

-- Set default theme
set.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
set.termguicolors = true

-- Numbers
set.relativenumber = true

-- Enable global clipboard
vim.o.clipboard = "unnamedplus"
    

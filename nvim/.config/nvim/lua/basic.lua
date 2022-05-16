local set = vim.opt

-- Use space as a the leader key
vim.g.mapleader = " "

-- Set the behavior of tab
set.autoindent = true
set.smartindent = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

-- Set default theme
vim.g["gruvbox_material_background"] = "hard" -- hard medium soft
vim.g["gruvbox_material_statusline_style"] = "mix"
set.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox-material]])
set.termguicolors = true

-- Numbers
set.relativenumber = true

-- Set statusline to be global, instead of one for each buffer
set.laststatus=3

-- Enable global clipboard
vim.o.clipboard = "unnamedplus"

-- Split new windows below and to the right
set.splitbelow = true
set.splitright = true

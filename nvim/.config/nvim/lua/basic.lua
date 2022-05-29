local set = vim.opt

-- Use space as a the leader key
vim.g.mapleader = " "

set.cursorline = true
set.wrap = false
set.scrolloff = 4
set.numberwidth = 4
set.signcolumn = "yes"
set.mouse = "a"

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
vim.cmd([[colorscheme catppuccin]])
set.termguicolors = true

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

-- Numbers
set.relativenumber = true
set.number = true

--For searching 
set.ignorecase = true
set.hlsearch = true

-- Set statusline to be global, instead of one for each buffer
set.laststatus=3

-- Enable global clipboard
vim.o.clipboard = "unnamedplus"

-- Split new windows below and to the right
set.splitbelow = true
set.splitright = true

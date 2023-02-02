local set = vim.opt

-- Use space as a the leader key
vim.g.mapleader = " "

set.cursorline = true
set.wrap = false
set.scrolloff = 6
set.numberwidth = 4
set.signcolumn = "yes"
set.mouse = "a"
set.cmdheight = 0

-- disable swap files
vim.cmd("noswapfile")

-- Set the behavior of tab
set.autoindent = true
set.smartindent = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = false -- Tabs over spaces

set.swapfile = false

-- Numbers
set.relativenumber = true
set.number = true

--For searching
set.ignorecase = true
set.hlsearch = true

-- Set statusline to be global, instead of one for each buffer
set.laststatus = 3

-- Enable global clipboard
vim.o.clipboard = "unnamedplus"

-- Split new windows below and to the right
set.splitbelow = true
set.splitright = true

-- Set end of buffer characters to be a space, instead of the default tilde.
set.fillchars = "eob: "

-- Backup and swapfile settings
set.hidden = true
set.backup = false
set.writebackup = false
set.updatetime = 300

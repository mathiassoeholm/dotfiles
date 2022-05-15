-- save all open buffers
vim.keymap.set('n', '<leader>z', ':wa<CR>')
-- close active buffer
vim.keymap.set('n', '<leader>q', ':b#|bd#<CR>')

vim.keymap.set('i', 'jk', '<ESC>')

-- Fugitive bindings
vim.keymap.set('n', '<leader>gs', ':G<CR>')
vim.keymap.set('n', '<leader>gh', ':diffget //2<CR>')
vim.keymap.set('n', '<leader>gl', ':diffget //3<CR>')

-- Move around to buffers
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Resize buffers
vim.keymap.set('n', '<C-Left>', ':vertical resize +3<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize -3<CR>')
vim.keymap.set('n', '<C-Up>', ':resize +3<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -3<CR>')

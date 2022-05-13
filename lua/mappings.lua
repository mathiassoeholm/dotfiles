-- save all open buffers
vim.keymap.set('n', '<leader>z', ':wa<CR>')
-- close active buffer
vim.keymap.set('n', '<leader>q', ':Bdelete<CR>')

vim.keymap.set('i', 'jk', '<ESC>')

-- Fugitive bindings
vim.keymap.set('n', '<leader>gs', ':G<CR>')
vim.keymap.set('n', '<leader>gh', ':diffget //2<CR>')
vim.keymap.set('n', '<leader>gl', ':diffget //3<CR>')


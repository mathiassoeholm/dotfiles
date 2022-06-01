-- save all open buffers
vim.keymap.set("n", "<leader>z", ":wa<CR>")
-- close active buffer
vim.keymap.set("n", "<leader>q", ":b#|bd#<CR>")

vim.keymap.set("i", "jk", "<ESC>")

-- Fugitive bindings
vim.keymap.set("n", "<leader>gs", ":G<CR>")
vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>")
vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>")

-- Move around to buffers
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize buffers
vim.keymap.set("n", "<C-Left>", ":vertical resize -3<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +3<CR>")
vim.keymap.set("n", "<C-Up>", ":resize -3<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +3<CR>")

-- Move buffer
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>")

-- Keymap for LSP Formatting, targeting active language server
-- vim.keymap.set("n", "<leader>m", ":Format<CR>")

vim.keymap.set("n", 's', "<Plug>Lightspeed_omni_s", { noremap = true, silent = true });

-- File explorer
vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>")

-- CoC specific bindings
vim.api.nvim_set_keymap("n", "<leader>.", "<Plug>(coc-codeaction)", {})
vim.api.nvim_set_keymap("n", "<leader>l", ":CocCommand eslint.executeAutofix<CR>", {})

vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", {silent = true})
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
vim.api.nvim_set_keymap("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
vim.api.nvim_set_keymap("n", "K", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", {})
vim.api.nvim_set_keymap("n", "<leader>m", ":CocCommand prettier.formatFile<CR>", {noremap = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
vim.api.nvim_set_keymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})

-- Copilot
vim.keymap.set("i", "<C-l>", 'copilot#Accept()', {silent = true, expr = true, script = true})
vim.g.copilot_no_tab_map = 1

-- Dashboard shortcuts for saving and loading sessions 
vim.keymap.set('n', '<Leader>ss', ':<C-u>SessionSave<CR>')
vim.keymap.set('n', '<Leader>sl', ':<C-u>SessionLoad<CR>')

-- change current word (like ciw) but repeatable with dot . for the same next word
vim.api.nvim_set_keymap("n", "<Leader>rs", ":let @/=expand('<cword>')<cr>cgn", {silent = true})




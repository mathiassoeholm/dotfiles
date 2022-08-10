local opts = {
    noremap = true,
    silent = true
}
local keymap = vim.api.nvim_set_keymap

keymap("n", "<space>", ':call VSCodeNotify("whichkey.show")<CR>', opts)
keymap("x", "<space>", ':call VSCodeNotify("whichkey.show")<CR>', opts)

-- Better Navigation
keymap("n", "<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", opts)
keymap("x", "<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", opts)
keymap("n", "<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", opts)
keymap("x", "<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", opts)
keymap("n", "<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)
keymap("x", "<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)
keymap("n", "<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)
keymap("x", "<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)

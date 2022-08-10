local opts = {
    noremap = true,
    silent = true
}
local keymap = vim.api.nvim_set_keymap

keymap("n", "<space>", ':call VSCodeNotify("whichkey.show")<CR>', opts)
keymap("x", "<space>", ':call VSCodeNotify("whichkey.show")<CR>', opts)

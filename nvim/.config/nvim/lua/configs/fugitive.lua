local M = {}

M.Compile = function(packerUse)
	packerUse({
		"tpope/vim-fugitive",
	})
end

M.Added = function()
	local opts = { noremap = true, silent = true }

	-- Fugitive bindings
	vim.keymap.set("n", "<leader>gs", ":G<CR>", opts)
	vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", opts)
	vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>", opts)
	vim.keymap.set("n", "<leader>gfh", ":0GcLog<CR>", opts)

	vim.keymap.set("n", "<leader>gcbn", ":!git rev-parse --abbrev-ref HEAD | pbcopy<CR>", opts)
end

return M

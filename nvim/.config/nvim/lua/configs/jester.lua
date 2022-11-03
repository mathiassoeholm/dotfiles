local M = {}

M.Compile = function(packerUse)
	packerUse("David-Kunz/jester")
end

M.Added = function()
	vim.keymap.set("n", "<leader>ja", ':lua require"jester".run_file()<CR>')
	vim.keymap.set("n", "<leader>jf", ':lua require"jester".run()<CR>')
end

return M

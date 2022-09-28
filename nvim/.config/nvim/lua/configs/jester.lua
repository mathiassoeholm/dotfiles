local M = {}

M.Compile = function(packerUse)
	packerUse("David-Kunz/jester")
end

M.Added = function()
	vim.keymap.set("n", "<leader>j", ':lua require"jester".run()<CR>')
end

return M

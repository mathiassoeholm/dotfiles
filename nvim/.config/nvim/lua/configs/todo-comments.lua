local M = {}

M.Compile = function(packerUse)
	packerUse({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})
end

return M

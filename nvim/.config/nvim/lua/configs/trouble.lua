local M = {}

M.Compile = function(packerUse)
	packerUse({
		"erikhoj/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				mode = "tsc",
			})
		end,
	})
end

return M

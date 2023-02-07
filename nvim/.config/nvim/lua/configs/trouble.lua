local M = {}

M.Compile = function(packerUse)
	packerUse({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
end

return M

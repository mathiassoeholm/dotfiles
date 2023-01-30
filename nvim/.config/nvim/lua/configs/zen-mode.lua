local M = {}

M.Compile = function(packerUse)
	packerUse({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
		end,
	})
end

return M

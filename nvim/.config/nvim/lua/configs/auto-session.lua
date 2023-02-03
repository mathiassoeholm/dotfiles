local M = {}

M.Compile = function(packerUse)
	packerUse({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
			})
		end,
	})
end

return M

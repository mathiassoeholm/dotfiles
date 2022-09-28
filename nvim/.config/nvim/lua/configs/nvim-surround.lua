local M = {}

M.Compile = function(packerUse)
	packerUse({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
end

return M

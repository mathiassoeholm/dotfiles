local M = {}

M.Compile = function(packerUse)
	packerUse({
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup({
				hook = function()
					local result = require("ts_context_commentstring.internal").update_commentstring()
				end,
			})
		end,
	})
end

return M

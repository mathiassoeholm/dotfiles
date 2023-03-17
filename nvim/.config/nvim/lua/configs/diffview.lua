
local M = {}

M.Compile = function(packerUse)
	packerUse({
		"sindrets/diffview.nvim",
	})
end

M.Added = function()
	local opts = { noremap = true, silent = true }


end

return M

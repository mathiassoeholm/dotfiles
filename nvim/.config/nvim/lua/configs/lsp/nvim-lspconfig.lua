local M = {}

M.Compile = function(packerUse)
	packerUse({
		"neovim/nvim-lspconfig",
	})
end

M.Added = function() end

return M

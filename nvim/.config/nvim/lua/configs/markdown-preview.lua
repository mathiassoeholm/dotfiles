local M = {}

M.Compile = function(packerUse)
	packerUse({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
end

return M

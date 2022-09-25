local function Compile(packerUse)
	packerUse({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
end

return { Compile = Compile }

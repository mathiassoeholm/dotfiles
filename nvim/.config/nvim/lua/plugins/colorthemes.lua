vim.opt.termguicolors = true

return {
	"folke/tokyonight.nvim",
	config = function()
		vim.opt.background = "dark"
		vim.cmd("colorscheme tokyonight-night")
	end,
}

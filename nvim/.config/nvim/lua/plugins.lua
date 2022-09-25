-- Remember to run :PackerCompile after modifying this value
local languageServer = "CoC" -- CoC or LSP

local configs = {
	require("configs.treesitter"),
	require("configs.treesitter-context"),
	require("configs.bufferline"),

	"nvim-treesitter/nvim-treesitter-textobjects",
	require("configs.lualine"),
	require("configs.dashboard"),
	require("configs.nvimtree"),
	require("configs.jester"),

	-- Deletes buffers while retaining window layout
	"famiu/bufdelete.nvim",
	"github/copilot.vim",
	require("configs.gitsigns"),

	require("configs.lightspeed"),

	require("configs.telescope"),
	"ckipp01/stylua-nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"tpope/vim-fugitive",

	-- Color themes
	require("configs.catppuccin"),
	"sainnhe/everforest",
	"ellisonleao/gruvbox.nvim",
	"sainnhe/gruvbox-material",

	require("configs.nvim-surround"),
	require("configs.markdown-preview"),

	-- Comment out lines of code
	require("configs.nvimcomment"),
}

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- -----------------------
	-- Setup languageServer
	-- -----------------------
	if languageServer == "CoC" then
		use({
			"neoclide/coc.nvim",
			branch = "release",
		})
		require("configs.coc")
	elseif languageServer == "LSP" then
		print("Missing implementation")
	end

	-- -----------------------
	-- Setup plugins
	-- -----------------------
	for _, package in ipairs(configs) do
		if package.Compile ~= nil then
			package.Compile(use)
		else
			use(package)
		end
	end

end)

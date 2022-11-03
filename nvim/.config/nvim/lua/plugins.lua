-- Swap between coc and lsp by commenting in/out here:
local languageServer = require("configs.coc")
-- local languageServer = require("configs.lsp")

local configs = {
	languageServer,

	require("configs.treesitter"),
	require("configs.treesitter-context"),
	"nvim-treesitter/nvim-treesitter-textobjects",

	require("configs.bufferline"),
	require("configs.lualine"),
	require("configs.dashboard"),
	require("configs.blankline"),

	"kyazdani42/nvim-web-devicons", -- optional, for file icon
	require("configs.nvimtree"),
	require("configs.telescope"),
	"fannheyward/telescope-coc.nvim",

	-- Showing nice popups and cmd line messages now that cmdheight is 0
	-- Try again with LSP instead of CoC
	-- require("configs.noice"),

	-- Deletes buffers while retaining window layout
	"famiu/bufdelete.nvim",

	-- Git
	"github/copilot.vim",
	require("configs.gitsigns"),
	"tpope/vim-fugitive",

	-- Motion
	require("configs.lightspeed"),

	"ckipp01/stylua-nvim",
	require("configs.jester"),
	require("configs.markdown-preview"),

	-- Color themes
	require("configs.catppuccin"),
	"sainnhe/everforest",
	"ellisonleao/gruvbox.nvim",
	"sainnhe/gruvbox-material",

	require("configs.nvim-surround"),

	"JoosepAlviste/nvim-ts-context-commentstring",
	-- Comment out lines of code
	require("configs.nvimcomment"),
}

-- For boopstraping
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

-- Remember to run :PackerCompile after adding or editing a plugin
local spartup = require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Setup plugins
	for _, package in ipairs(configs) do
		if package.Compile ~= nil then
			package.Compile(use)
		else
			use(package)
		end
	end

	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require("packer").sync()
	end
end)

-- Call added to all wrapped plugins
for _, package in ipairs(configs) do
	if package.Added ~= nil then
		package.Added()
	end
end

return spartup

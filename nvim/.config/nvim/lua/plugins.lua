return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- -----------------------
	-- LSP WIP
	-- -----------------------
	-- Native support for running different language servers
	-- use({
	-- 	"williamboman/nvim-lsp-installer",
	-- 	"neovim/nvim-lspconfig",
	-- })
	-- require("configs.lspconfig")

	-- -----------------------
	-- CoC
	-- -----------------------
	use({ "neoclide/coc.nvim", branch = "release" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- For better highlighting and file knowlage
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/nvim-treesitter-textobjects")

	use("glepnir/dashboard-nvim")

	-- File explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})

    -- used for jest testing
	use("David-Kunz/jester")

	-- Deletes buffers while retaining window layout
	use("famiu/bufdelete.nvim")

	-- For some pretty tab lines
	use("lukas-reineke/indent-blankline.nvim")

	-- Setup Copilot
	use({ "github/copilot.vim" })

	-- github visible feedback
	use({
		"lewis6991/gitsigns.nvim",
	})

	-- Jump around the buffer
	use("ggandor/lightspeed.nvim")

	-- display cursors function, class and other context out of view
	use("nvim-treesitter/nvim-treesitter-context")

	-- fuzzy finder for searhcing files and other stuff
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- Use fzf for searching, Much faster searching
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Like Prettier but styling for Lua
	use({ "ckipp01/stylua-nvim" }) -- use({ "ckipp01/stylua-nvim" })

	-- Themes
	use({ "ellisonleao/gruvbox.nvim" })
	use({ "sainnhe/gruvbox-material" })
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})

	use({ "p00f/nvim-ts-rainbow" })

	-- comment out lines of code
	use("terrortylor/nvim-comment")
	-- Reads type of line instead of file type. Helpful for files types with multiple languages in them, (tsx, vim, html, etc.)
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- github implementation
	use({ "tpope/vim-fugitive" })

	-- surround, replace and add stuff with '"`{[( and tags
	-- use({ "tpope/vim-surround" })
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	-- Tabs and Buffers
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

	-- Run :MarkdownPreview to get a live preview in browser tab
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
end)

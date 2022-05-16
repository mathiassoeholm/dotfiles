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
	require("configs.coc")

	-- Statusline at the bottom
	-- use({
	-- 	"nvim-lualine/lualine.nvim",
	-- 	requires = { "kyazdani42/nvim-web-devicons", opt = true },
	-- })
	-- require("configs.lualine")

	-- For better highlighting and file knowlage
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	require("configs.treesitter")

	-- File explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})
	require("configs.nvimtree")

    -- Setup Copilot
    use {"github/copilot.vim"}   
    use{
        "zbirenbaum/copilot.lua",
        event = {"VimEnter"},
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
        end,
    }

    use {
      'lewis6991/gitsigns.nvim',
    }
	require("configs.gitsigns")

	-- fuzzy finder for searhcing files and other stuff
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- Use fzf for searching, Much faster searching
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	require("configs.telescope")

	-- Like Prettier but styling for Lua
	use({ "ckipp01/stylua-nvim" })
	require("configs.stylua")

	-- Themes
	use({ "ellisonleao/gruvbox.nvim" })
	use({ "sainnhe/gruvbox-material" })

	-- comment out lines of code
	use({ "tpope/vim-commentary" })
	-- github implementation
	use({ "tpope/vim-fugitive" })
	-- surround, replace and add stuff with '"`{[( and tags
	use({ "tpope/vim-surround" })

	-- Tabs and Buffers
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
	require("configs.bufferline")

	-- Run :MarkdownPreview to get a live preview in browser tab
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
end)

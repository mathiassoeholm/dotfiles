return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			vim.opt.completeopt = "menu,menuone,noselect"

			local luasnip = require("luasnip")

			-- Get html snippets in react tsx/jsx files
			luasnip.filetype_extend("javascriptreact", { "html" })
			luasnip.filetype_extend("typescriptreact", { "html" })

			-- load friendly-snippets
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
	},
	{
		"saadparwaiz1/cmp_luasnip",
	},

	-- NOTE: 
	-- `rafamadriz/friendly-snippets` is loaded and added as a dependency of nvim-cmp
	-- This needs to also be added as a dependency to nvim-cmp and cmp-nvim-lsp for it to work
	-- See nvim-cmp.lua
}

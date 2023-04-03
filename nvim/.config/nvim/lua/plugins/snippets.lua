return {
	{
		"L3MON4D3/LuaSnip",
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
	{
		"rafamadriz/friendly-snippets",
	},
}

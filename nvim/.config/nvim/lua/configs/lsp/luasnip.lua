local M = {}

M.Compile = function(packerUse)
	packerUse({
		"L3MON4D3/LuaSnip",
		config = function()
			-- load friendly-snippets
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
	})

	packerUse({
		"saadparwaiz1/cmp_luasnip",
	})

	packerUse({
		"rafamadriz/friendly-snippets",
	})
end

M.Added = function()
	vim.opt.completeopt = "menu,menuone,noselect"
end

return M

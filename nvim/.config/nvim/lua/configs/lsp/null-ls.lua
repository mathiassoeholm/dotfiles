local M = {}

M.Compile = function(packerUse)
	packerUse({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("null-ls").setup({
				sources = {
					require("null-ls").builtins.formatting.stylua,
					require("null-ls").builtins.formatting.prettierd,
					-- require("null-ls").builtins.diagnostics.tsc,
					-- require("null-ls").builtins.diagnostics.eslint,
					-- require("null-ls").builtins.completion.spell,
				},
			})
		end,
	})
end

M.Added = function() end

return M

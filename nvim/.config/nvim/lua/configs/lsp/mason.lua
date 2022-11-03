local M = {}

M.Compile = function(packerUse)
	packerUse({
		"williamboman/mason.nvim",
		config = {
			require('mason').setup({
			})

		}
	})

	packerUse({
		"jayp0521/mason-null-ls.nvim",
		config = {
			require('mason-null-ls').setup({
				ensure_installed = {
					"stylua",
					"prettierd",
					"spell",
				},
			})
		}
	})
end

M.Added = function() end

return M

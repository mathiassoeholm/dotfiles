local M = {}

M.Compile = function(packerUse)
	packerUse({
		"williamboman/mason.nvim",
		config = {
			require("mason").setup({}),
		},
	})

	packerUse({
		"williamboman/mason-lspconfig",
		config = {
			require("mason-lspconfig").setup({
				ensure_installed = {
					"tsserver",
					"html",
					"sumneko_lua",
					"cssls",
					"jsonls",
					"bashls",
					"gopls",
					"dockerls",
					"eslint",
					"marksman",
					"taplo",
					"yamlls",
				},
			}),
		},
	})

	packerUse({
		"jayp0521/mason-null-ls.nvim",
		config = {
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					"prettierd",
					"spell",
				},
			}),
		},
	})
end

M.Added = function() end

return M

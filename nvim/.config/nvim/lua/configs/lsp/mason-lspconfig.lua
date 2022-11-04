local M = {}

M.Compile = function(packerUse)
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
end

M.Added = function() end

return M

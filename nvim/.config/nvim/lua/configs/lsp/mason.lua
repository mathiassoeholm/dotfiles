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

M.Added = function()
	-- Simple standard setup
	local basicServerSetup = {
		"html",
		"cssls",
		"jsonls",
		"bashls",
		"gopls",
		"dockerls",
		"eslint",
		"marksman",
		"taplo",
		"yamlls",
	}

	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local keybinds = require("configs.lsp.lsp-mappings").on_attach
	for _, server in ipairs(basicServerSetup) do
		lspconfig[server].setup({
			on_attach = keybinds,
			capabilities = capabilities,
		})
	end

	-- custom setup
	require("typescript").setup({
		server = {
			capabilities = capabilities,
			on_attach = keybinds,
		},
	})


	lspconfig["sumneko_lua"].setup({
		capabilities = capabilities,
		on_attach = keybinds,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					},
				},
			},
		},
	})
end

return M

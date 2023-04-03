local M = {}

M.Compile = function(packerUse)
	packerUse({
		"williamboman/mason.nvim",
		config = function()
			local setup, package = pcall(require, "mason-lspconfig")
			if not setup then
				return
			end
			require("mason").setup({})
		end,
	})

	packerUse({
		"williamboman/mason-lspconfig",
		config = function()
			local setup, package = pcall(require, "mason-lspconfig")
			if not setup then
				return
			end

			package.setup({
				-- ensure_installed = {
				-- 	"tsserver",
				-- 	"html",
				-- 	"lua_ls",
				-- 	"cssls",
				-- 	"jsonls",
				-- 	"bashls",
				-- 	"dotls",
				-- 	"gopls",
				-- 	"dockerls",
				-- 	"eslint",
				-- 	"marksman",
				-- 	"taplo",
				-- 	"yamlls",
				-- 	"tailwindcss",
				-- },
			})
		end,
	})

	packerUse({
		"jayp0521/mason-null-ls.nvim",
		config = function()
			local setup, package = pcall(require, "mason-lspconfig")
			if not setup then
				return
			end
			package.setup({})
		end,
	})
end

M.Added = function()
	-- Simple standard setup
	local basicServerSetup = {
		"html",
		"cssls",
		"jsonls",
		"bashls",
		"dockerls",
		"eslint",
		"dotls",
		"svelte",
		"marksman",
		"taplo",
		"yamlls",
		"tailwindcss",
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

	lspconfig["gopls"].setup({
		on_attach = keybinds,
		capabilities = capabilities,
		settings = {
			gopls = {
				gofumpt = true,
			},
		},
	})

	-- custom setup
	require("typescript").setup({
		server = {
			capabilities = capabilities,
			on_attach = keybinds,
		},
	})

	lspconfig["lua_ls"].setup({
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

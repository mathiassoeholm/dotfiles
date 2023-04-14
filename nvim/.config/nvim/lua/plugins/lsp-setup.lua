return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"jose-elias-alvarez/typescript.nvim",
		config = function()
			require("typescript").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			require("mason-lspconfig").setup({})
			mason_lspconfig.setup_handlers({
				function(server_name)
					local serverConfig = {
						on_attach = function(client, bufnr)
							-- keybind options
							local opts = { noremap = true, silent = true, buffer = bufnr }
							local keymap = vim.keymap

							-- set keybinds
							-- keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { silent = true })
							keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)    -- show definition, references
							keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
							keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
							keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
							keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
							keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
							keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
							keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
							keymap.set("n", "(", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
							keymap.set("n", ")", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
							keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)      -- show documentation for what is under cursor
							keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

							keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format {async=true}<CR>", opts) -- format buffer

							-- Eriks seje keybindings --
							keymap.set("i", "<C-k>", "<Up>", opts) -- Bind the up key to Ctrl+k
							keymap.set("i", "<C-j>", "<Down>", opts) -- Bind the up key to Ctrl+j

							-- typescript specific keymaps (e.g. rename file and update imports)
							if client.name == "tsserver" then
								client.server_capabilities.documentFormattingProvider = false
								keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
								keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
								keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
							end

							if client.name == "gopls" then
								-- use the gopls formatting,
								-- see the lsp setup using 'gofumpt'
								client.server_capabilities.documentFormattingProvider = true
							end
						end,
					}

					if server_name == "lua_ls" then
						serverConfig.settings = {
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
						}
					end

					if server_name == "gopls" then
						serverConfig.settings = {
							gopls = {
								gofumpt = true,
							},
						}
					end

					require("lspconfig")[server_name].setup(serverConfig)
				end,
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
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
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				automatic_setup = true,
			})

			require("mason-null-ls").setup_handlers() -- If `automatic_setup` is true.
		end,
	},
}

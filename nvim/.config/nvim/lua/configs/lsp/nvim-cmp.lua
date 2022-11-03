local M = {}

M.Compile = function(packerUse)
	packerUse({
		"hrsh7th/nvim-cmp",
	})

	packerUse({
		"hrsh7th/cmp-buffer",
	})

	packerUse({
		"hrsh7th/cmp-path",
	})

	packerUse({
		"hrsh7th/cmp-nvim-lsp",
		config = function()

		end
	})

	packerUse({
		"glepnir/lspsaga.nvim", branch = "main",
		config = function()
			local saga = require('lspsaga')
			saga.init_lsp_saga({
				finder_action_keys = {
					open = "<CR>"
				},
				definition_action_keys = {
					edit = "<CR>"
				}
			})
		end
		
	})

	packerUse({
		"onsails/lspkind.nvim",
	})
end

M.Added = function() 

	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local keybinds = require("configs.lsp.keymaps").on_attach

	local cmp = require('cmp')
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({
				select = true,
			}),
		}),
		sources = cmp.config.sources({
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "nvim_lsp" },
		}),
		formatting ={
			format = require("lspkind").cmp_format({
				maxwidth = 50,
				ellipsis_char = "...",
			}),
		}
	})

	lspconfig["html"].setup({
		capabilities = capabilities,
		on_attach = keybinds,
	})

	lspconfig["cssls"].setup({
		capabilities = capabilities,
		on_attach = keybinds,
	})

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
			}
		}
	})
			
end

return M

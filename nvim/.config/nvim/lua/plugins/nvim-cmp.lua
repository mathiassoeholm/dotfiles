return {
	"onsails/lspkind.nvim",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	{
		"hrsh7th/cmp-nvim-lsp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
		config = function() end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "friendly-snippets" },
		config = function()
			local cmp = require("cmp")
			local compare = cmp.config.compare
			cmp.setup({
				window = {
					completion = {
						-- rounded border; thin-style scrollbar
						border = "rounded",
						scrollbar = "║",
					},
					documentation = {
						border = "rounded",
						scrollbar = "║",
					},
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sorting = {
					-- for sorting we can also add a priority to the sources down below. `{name = "luasnip", priority = 3}` as an example
					comparators = {
						compare.locality,
						compare.recently_used,
						compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
						compare.offset,
						compare.order,
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						-- for copilot
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				}),
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "luasnip" },
					{ name = "path" },
					-- { name = "buffer" },
					{ name = "nvim_lsp" },
				}),
				formatting = {
					format = require("lspkind").cmp_format({
						maxwidth = 50,
						symbol_map = { Copilot = "" },
						ellipsis_char = "...",
					}),
				},
			})
		end,
	},
}

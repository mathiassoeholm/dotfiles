local M = {}

M.Compile = function(packerUse)
	packerUse({
		"hrsh7th/nvim-cmp",
	})
end

M.Added = function()
	local cmp = require("cmp")
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
				-- for copilot
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
		}),
		sources = cmp.config.sources({
			{ name = "copilot" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
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

end

return M

return {
	{
		"glepnir/lspsaga.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
		event = "LspAttach",
		config = function()
			local saga = require("lspsaga")
			saga.setup({
				border_style = "rounded",
				code_action_lightbulb = {
					enable = false,
				},
				lightbulb = {
					enable = false,
				},
				code_action = {
					keys = {
						quit = "<ESC>",
					},
				},
				rename = {
					quit = "<ESC>",
				},
				finder_action_keys = {
					open = "<CR>",
					quit = "<ESC>",
				},
				definition_action_keys = {
					edit = "<CR>",
					quit = "<ESC>",
				},
				symbol_in_winbar = {
					enable = true,
					hide_keyword = true,
					respect_root = true,
					show_file = true,
					separator = "  ",
					ignore_patterns = { ".*" },
				},
			})
		end,
	},
}

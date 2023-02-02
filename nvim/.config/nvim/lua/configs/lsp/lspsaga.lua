local M = {}

M.Compile = function(packerUse)
	packerUse({
		"glepnir/lspsaga.nvim",
		branch = "main",
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
				finder_action_keys = {
					open = "<CR>",
					quit = "<ESC>",
				},
				definition_action_keys = {
					edit = "<CR>",
					quit = "<ESC>",
				},
			})
		end,
	})
end

return M

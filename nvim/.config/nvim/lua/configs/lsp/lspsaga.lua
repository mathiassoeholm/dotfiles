
local M = {}

M.Compile = function(packerUse)
	packerUse({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga({
				border_style = "rounded",
				finder_action_keys = {
					open = "<CR>",
				},
				definition_action_keys = {
					edit = "<CR>",
				},
			})
		end,
	})
end


return M

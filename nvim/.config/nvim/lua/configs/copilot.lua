local M = {}

M.Compile = function(packerUse)
	packerUse({
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					-- suggestion = {
					-- 	auto_trigger = true,
					-- },
					suggestion = {
						auto_trigger = true,
						keymap = {
							accept = "<C-e>",
						},
					},
				})
			end, 100)
		end,
	})
	packerUse({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup({
				-- method = "getPanelCompletions",
			})
		end,
	})
end

return M

return {
	{
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
	},
}

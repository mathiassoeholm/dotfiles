return {
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				config = {
					shortcut = {
						{
							desc = "Serious Code, Silly Games",
						},
					},
					header = {
						"                                       ███    ",
						"                                      ████ ███",
						"                                   ██████████ ",
						"                  ███████████     ███   ████  ",
						"                █████     █████  ███     ███  ",
						"               ███▌   ██    ████         ███  ",
						"              ████    ████   ███        ████  ",
						"               ███     ███   ███        ███   ",
						"        ████    ████  ████   ███       ███    ",
						"      ████████   ████████   ███      ████     ",
						"     ████  █████         █████     █████      ",
						" ██████      ███████████████    █████         ",
						"███              ███████       ██             ",
						"",
					},
					packages = { enable = false },
					footer = {},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}

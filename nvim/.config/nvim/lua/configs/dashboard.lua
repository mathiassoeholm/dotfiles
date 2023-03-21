local M = {}

M.Compile = function(packerUse)
	packerUse({
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
		requires = { "nvim-tree/nvim-web-devicons" },
	})
end

return M

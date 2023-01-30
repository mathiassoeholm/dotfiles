local M = {}

M.Added = function()
	local db = require("dashboard")

	db.custom_header = {
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
	}

	db.custom_center = {
		{ desc = "Erik er lol" },
	}

	db.custom_footer = {
		"Serious Code, Silly Games",
	}

	-- -- disable the indenLine while dashboard is open
	vim.g.indentLine_fileTypeExclude = { "dashboard" }
	db.default_executive = "telescope"

	-- -- Dashboard shortcuts for saving and loading sessions
	vim.keymap.set("n", "<Leader>ss", ":<C-u>SessionSave<CR>")
	vim.keymap.set("n", "<Leader>sl", ":<C-u>SessionLoad<CR>")
end

M.Compile = function(packerUse)
	packerUse("glepnir/dashboard-nvim")
end

return M

vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_custom_header = {
	"                                       ███",
	"                                      ████ ███",
	"                                   ██████████",
	"                  ███████████     ███   ████",
	"                █████     █████  ███     ███",
	"               ███▌   ██    ████         ███",
	"              ████    ████   ███        ████",
	"               ███     ███   ███        ███",
	"        ████    ████  ████   ███       ███",
	"      ████████   ████████   ███      ████",
	"     ████  █████         █████     █████",
	" ██████      ███████████████    █████",
	"███              ███████       ██",
	"",
}

-- Alernative NooB snail
-- vim.g.dashboard_custom_header = {
--     '     .----.   @   @',
--     '    / .-"-.`.  \\v/',
--     "    | | '\\ \\ \\_/ )",
--     "  ,-\\ `-.' /.'  /",
--     " '---`----'----'"
-- }

-- disable the indenLine while dashboard is open
vim.g.indentLine_fileTypeExclude = { "dashboard" }

vim.g.dashboard_custom_footer = {
	"Serious Code, Silly Games",
}

-- Dashboard shortcuts for saving and loading sessions
vim.keymap.set("n", "<Leader>ss", ":<C-u>SessionSave<CR>")
vim.keymap.set("n", "<Leader>sl", ":<C-u>SessionLoad<CR>")

local function Compile(packerUse)
	packerUse("glepnir/dashboard-nvim")
end
return { Compile = Compile }

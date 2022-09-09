-- Keybing for toggleing favourite themes
local currentTheme = 1
local function setColorMode(mode)
	vim.opt.background = mode

	local themePath
	if mode == "dark" then
		themePath = string.format(vim.env.HOME .. "/.config/kitty/catpuccino-theme.conf")
	else
		themePath = string.format(vim.env.HOME .. "/.config/kitty/catpuccino-theme-light.conf")
	end

	-- TODO change kitty terminal color scheme as well to change the cursor
	-- handle = vim.loop.spawn("kitty", {
	-- 	args = {
	-- 		"@",
	-- 		"set-colors",
	-- 		"-c",
	-- 		themePath,
	-- 	},
	-- }, function()
	-- 	print("DOCUMENT CONVERSION COMPLETE")
	-- 	handle:close()
	-- end)
end

local themes = {
	{
		mode = "dark",
		colorscheme = "gruvbox",
	},
	{
		mode = "light",
		colorscheme = "gruvbox",
	},
	{
		mode = "dark",
		colorscheme = "catppuccin",
		global = {
			catppuccin_flavour = "mocha",
		},
	},
	{
		mode = "light",
		colorscheme = "catppuccin",
		global = {
			catppuccin_flavour = "latte",
		},
	},
	{
		mode = "dark",
		colorscheme = "everforest",
		global = {
			everforest_background = "hard",
			everforest_enable_italic = 1,
		},
	},
	{
		mode = "light",
		colorscheme = "everforest",
		global = {
			everforest_background = "soft",
			everforest_enable_italic = 1,
		},
	},
}

function toggleTheme()
	currentTheme = currentTheme + 1
	if currentTheme > #themes then
		currentTheme = 1
	end

	local theme = themes[currentTheme]
	setColorMode(theme.mode)
	if theme.global then
		for key, value in pairs(theme.global) do
			vim.g[key] = value
		end
	end

	vim.cmd("colorscheme " .. theme.colorscheme)
end

vim.api.nvim_set_keymap("n", "<C-T>", ":lua toggleTheme()<CR>", { silent = true })

vim.opt.termguicolors = true

currentTheme = 4
toggleTheme()

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
		colorscheme = "tokyonight-moon",
	},
	{
		mode = "light",
		colorscheme = "tokyonight-day",
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

-- Set default start theme
local currentTheme = 5
local function setColorMode(mode)
	vim.opt.background = mode

	-- TODO change kitty terminal color scheme as well to change the cursor
	-- local themePath
	-- if mode == "dark" then
	-- 	themePath = string.format(vim.env.HOME .. "/.config/kitty/catpuccino-theme.conf")
	-- else
	-- 	themePath = string.format(vim.env.HOME .. "/.config/kitty/catpuccino-theme-light.conf")
	-- end
	--
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

local function setColorTheme(index)
	local theme = themes[index]
	setColorMode(theme.mode)
	if theme.global then
		for key, value in pairs(theme.global) do
			vim.g[key] = value
		end
	end

	vim.cmd("colorscheme " .. theme.colorscheme)
end

function NextTheme()
	currentTheme = currentTheme + 1
	if currentTheme > #themes then
		currentTheme = 1
	end

	setColorTheme(currentTheme)
end

vim.opt.termguicolors = true
vim.api.nvim_set_keymap("n", "<C-a>", ":lua NextTheme()<CR>", { silent = true })

-- Set default start theme
setColorTheme(currentTheme)

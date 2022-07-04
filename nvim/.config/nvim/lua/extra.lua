-- Keybing for toggleing favourite themes
local currentTheme = 2
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

function ToggleTheme()
	currentTheme = (currentTheme + 1) % 6
	if currentTheme == 0 then
		setColorMode("light")
		vim.cmd([[colorscheme gruvbox]])
	elseif currentTheme == 1 then
		setColorMode("dark")
		vim.cmd([[colorscheme gruvbox]])
	elseif currentTheme == 2 then
		setColorMode("dark")
		vim.g.catppuccin_flavour = "mocha"
		vim.cmd([[colorscheme catppuccin]])
	elseif currentTheme == 3 then
		setColorMode("dark")
		vim.g.catppuccin_flavour = "macchiato"
		vim.cmd([[colorscheme catppuccin]])
	elseif currentTheme == 4 then
		setColorMode("dark")
		vim.g.catppuccin_flavour = "frappe"
		vim.cmd([[colorscheme catppuccin]])
	elseif currentTheme == 5 then
		setColorMode("light")
		vim.g.catppuccin_flavour = "latte"
		vim.cmd([[colorscheme catppuccin]])
	end

end

vim.api.nvim_set_keymap("n", "<C-T>", ":lua ToggleTheme()<CR>", { silent = true })

-- Set default theme
vim.opt.termguicolors = true
vim.g["gruvbox_material_background"] = "hard" -- hard medium soft
vim.g["gruvbox_material_statusline_style"] = "mix"
vim.opt.background = "dark" -- or "light" for light mode

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.cmd([[colorscheme catppuccin]])

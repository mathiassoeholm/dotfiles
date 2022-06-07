-- Keybing for toggleing favourite themes
local currentTheme = 2
function ToggleTheme()
	currentTheme = (currentTheme + 1) % 6
	if currentTheme == 0 then
		vim.opt.background = "light"
		vim.cmd([[colorscheme gruvbox]])
	elseif currentTheme == 1 then
		vim.opt.background = "dark"
		vim.cmd([[colorscheme gruvbox]])
	elseif currentTheme == 2 then
		vim.g.catppuccin_flavour = "mocha"
		vim.opt.background = "dark"
		vim.cmd([[colorscheme catppuccin]])
	elseif currentTheme == 3 then
		vim.g.catppuccin_flavour = "macchiato"
		vim.opt.background = "dark"
		vim.cmd([[colorscheme catppuccin]])
	elseif currentTheme == 4 then
		vim.g.catppuccin_flavour = "frappe"
		vim.opt.background = "dark"
		vim.cmd([[colorscheme catppuccin]])
	elseif currentTheme == 5 then
		vim.g.catppuccin_flavour = "latte"
		vim.opt.background = "light"
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

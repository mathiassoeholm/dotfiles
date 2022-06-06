-- Keybing for toggleing favourite themes
local currentTheme = 2;
function ToggleTheme()
    if currentTheme == 0 then
        vim.opt.background = "light"
        vim.cmd([[colorscheme gruvbox]])
    elseif currentTheme == 1 then
        vim.g.catppuccin_flavour = "mocha"
        vim.opt.background = "dark"
        vim.cmd([[colorscheme catppuccin]])
    elseif currentTheme == 2 then
        vim.opt.background = "dark"
        vim.cmd([[colorscheme gruvbox]])
    end

    currentTheme = (currentTheme + 1) % 3
end

vim.api.nvim_set_keymap("n", "<Leader>t", ":lua ToggleTheme()<CR>", {silent = true})

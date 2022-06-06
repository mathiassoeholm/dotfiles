-- Keybing for toggleing light and dark theme using catppuccin
local currentTheme = vim.g.catppuccin_flavour; 
function ToggleTheme()
    if currentTheme == "mocha" then
        currentTheme = "latte"
        vim.opt.background = "light"
        vim.cmd([[colorscheme gruvbox]])
    elseif currentTheme == "latte" then
        currentTheme = "mocha"
        vim.g.catppuccin_flavour = currentTheme
        vim.opt.background = "dark"
        vim.cmd([[colorscheme catppuccin]])
    end

    -- force reload
end

vim.api.nvim_set_keymap("n", "<Leader>t", ":lua ToggleTheme()<CR>", {silent = true})

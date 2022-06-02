-- Keybing for toggleing light and dark theme using catppuccin
local currentTheme = vim.g.catppuccin_flavour; 
function ToggleTheme()
    if currentTheme == "mocha" then
        currentTheme = "latte"
    elseif currentTheme == "latte" then
        currentTheme = "mocha"
    end

    vim.g.catppuccin_flavour = currentTheme
    -- force reload
    vim.cmd([[colorscheme catppuccin]])
end

vim.api.nvim_set_keymap("n", "<Leader>t", ":lua ToggleTheme()<CR>", {silent = true})

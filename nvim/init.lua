require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.hop"

if vim.g.vscode then
    require "user.vscode"
else
    require "user.colorscheme"
end

require "user.options"
require "user.keymaps"
require "user.plugins"

if vim.g.vscode then
    require "user.vscode"
else
    require "user.colorscheme"
    require "user.cmp"
end

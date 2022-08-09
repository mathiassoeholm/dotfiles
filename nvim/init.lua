require "user.options"
require "user.keymaps"

if vim.g.vscode then
    require "user.vscode"
else
    require "user.plugins"
    require "user.colorscheme"
    require "user.cmp"
    require "user.lsp"
end

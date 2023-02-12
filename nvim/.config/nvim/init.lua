require("basic")
require("plugins")
require("default-mappings")

require("theming")
require("projects")

local trouble_extensions = require("trouble-extensions")
vim.api.nvim_create_user_command("Diagnose", trouble_extensions.diagnose, {})

vim.api.nvim_set_keymap("n", "<leader>di", ":Diagnose<CR>", { noremap = true, silent = true })

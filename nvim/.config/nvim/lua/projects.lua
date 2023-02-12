local registry = require("projects.project_registry")

registry.set("project-grim", require("projects.grim"))

local active_project = registry.get_active_project()

vim.api.nvim_create_user_command("Build", active_project.build, {})
vim.api.nvim_set_keymap("n", "<leader>bb", ":Build<CR>", { noremap = true, silent = true })

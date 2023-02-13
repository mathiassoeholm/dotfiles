local M = {}

M.Compile = function(packerUse)
	packerUse({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})

			local trouble_extensions = require("trouble-extensions")
			vim.api.nvim_create_user_command("Diagnose", trouble_extensions.diagnose, {})
		end,
	})
end

M.Added = function()
	vim.api.nvim_set_keymap("n", "<leader>di", ":Diagnose<CR>", { noremap = true, silent = true })
end

return M

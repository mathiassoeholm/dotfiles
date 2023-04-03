return {
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					adaptive_size = true,
					side = "right",
					mappings = {
						list = {
							{ key = "u", action = "dir_up" },
							{ key = "<C-t>", action = "" },
						},
					},
				},
				git = {
					ignore = false,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					custom = { "node_modules", ".DS_STORE" },
				},
				notify = {
					threshold = vim.log.levels.ERROR,
				},
			})

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", opts)
		end,
	},
}

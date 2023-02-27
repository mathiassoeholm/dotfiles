local M = {}

M.Compile = function(packerUse)
	packerUse({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
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
		end,
	})
end

M.Added = function()
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", opts)
end

return M

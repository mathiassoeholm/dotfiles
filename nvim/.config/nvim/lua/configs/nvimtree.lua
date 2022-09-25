vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>")

local function Compile(packerUse)
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
					mappings = {
						list = {
							{ key = "u", action = "dir_up" },
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
			})
		end,
	})
end

return { Compile = Compile }

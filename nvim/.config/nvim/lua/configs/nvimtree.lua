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

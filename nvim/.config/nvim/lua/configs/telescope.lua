local M = {}

M.Added = function()
	-- Find files using Telescope command-line sugar.
	vim.keymap.set("n", "<C-p>", "<cmd>Telescope git_files<CR>")
	vim.keymap.set("n", "<C-b>", "<cmd>Telescope resume<CR>")
	vim.keymap.set("n", "<S-f>", "<cmd>Telescope live_grep<CR>")
	vim.keymap.set("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>")



end

M.Compile = function(packerUse)
	packerUse({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("telescope").setup({
				-- pickers = {
				-- 	find_files = {
				-- 		theme = "ivy",
				-- 	},
				-- },
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})

			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("noice")
			-- only used with CoC
			-- require("telescope").load_extension("coc")
		end,
	})
end

return M

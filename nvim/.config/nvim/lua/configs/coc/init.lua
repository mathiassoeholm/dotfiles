local M = {}

M.Compile = function(packerUse)
	packerUse({
		"neoclide/coc.nvim",
		branch = "release",
	})
end

M.Added = function()
	vim.g.coc_global_extensions = {
		"coc-highlight",
		"coc-html",
		"coc-jest",
		"coc-snippets",
		"coc-prettier",
		"coc-json",
		"coc-sumneko-lua",
		"coc-emmet",
		"coc-spell-checker",
		"coc-go",
		"coc-css",
		"coc-pairs",
		"coc-tsserver",
		"coc-styled-components",
		"coc-eslint",
	}

	-- Mapping
	vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(coc-codeaction)", {})
	vim.api.nvim_set_keymap("n", "<leader>l", ":CocCommand eslint.executeAutofix<CR>", {})

	-- vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { silent = true })
	vim.api.nvim_set_keymap("n", "gr", "<cmd>Telescope coc references<CR>", { silent = true })
	vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
	vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
	vim.api.nvim_set_keymap("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
	vim.api.nvim_set_keymap("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", {})
	vim.api.nvim_set_keymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
	vim.api.nvim_set_keymap(
		"i",
		"<TAB>",
		"coc#pum#visible() ? '<C-n>' : '<TAB>'",
		{ noremap = true, silent = true, expr = true }
	)
	vim.api.nvim_set_keymap("i", "<S-TAB>", "coc#pum#visible() ? '<C-p>' : '<C-h>'", { noremap = true, expr = true })
	vim.api.nvim_set_keymap(
		"i",
		"<CR>",
		"coc#pum#visible() ? coc#pum#confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'",
		{ silent = true, expr = true, noremap = true }
	)

	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("n", "<leader>f", [[<cmd>lua require("stylua-nvim").format_file()<CR>]], opts)
end

return M

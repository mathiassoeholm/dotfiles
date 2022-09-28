local M = {}

M.Compile = function(packerUse)
	packerUse({
		"ggandor/lightspeed.nvim",
		config = function()
			require("lightspeed").setup({
				ignore_case = true,
			})
		end,
	})
end

M.Added = function()
	-- Remap for lightspeed to use global search instead i=of directional
	vim.keymap.set("n", "s", "<Plug>Lightspeed_omni_s", { noremap = true, silent = true })
end

return M

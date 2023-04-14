return {
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"go",
					"rust",
					"typescript",
					"javascript",
					"jsdoc",
					"css",
					"http",
					"scss",
					"html",
					"dockerfile",
					"gomod",
					"gowork",
					"json",
					"json5",
					"yaml",
					"kotlin",
					"php",
					"python",
					"regex",
					"svelte",
					"toml",
					"tsx",
					"markdown",
					"bash",
					"markdown_inline",
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
				-- For the plugin JoosepAlviste/nvim-ts-context-commentstring
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				indent = {
					enable = true,
				},
				highlight = {
					-- `false` will disable the whole extension
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}

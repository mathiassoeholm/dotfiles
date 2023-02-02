local M = {}

M.Compile = function(packerUse)
	packerUse({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			-- Forcing compiler to use gcc. This fixed an issue I had on my machine.
			-- Togehter with a symlink fix that was really anoying.
			-- Read more on the solution here: https://github.com/tree-sitter/tree-sitter-haskell/issues/34#issuecomment-892960976
			-- require("nvim-treesitter.install").compilers = { "gcc" }
			require("nvim-treesitter.configs").setup({
				-- A list of :checkhealth nvim_treesitter parser names, or "all"
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
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = true,

				-- For the plugin JoosepAlviste/nvim-ts-context-commentstring
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},

				indent = {
					enable = true,
				},

				-- rainbow = {
				-- 	enable = true,
				-- 	-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
				-- 	extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				-- 	max_file_lines = nil, -- Do not enable for files with more than n lines, int
				-- 	-- colors = {}, -- table of hex strings
				-- 	-- termcolors = {} -- table of colour name strings
				-- },

				-- List of parsers to ignore installing (for "all")
				highlight = {
					-- `false` will disable the whole extension
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					-- disable = { "c", "rust" },

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				textobjects = {
					swap = {
						enable = true,
						swap_next = {
							[">"] = { "@parameter.inner", "@function.outer" },
						},
						swap_previous = {
							["<"] = { "@parameter.inner", "@function.outer" },
						},
					},
				},
			})
		end,
	})
end

return M

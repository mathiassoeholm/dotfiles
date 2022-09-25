-- :h bufferline-configuration
require("bufferline").setup({
	options = {
		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		indicator = {
			icon = "▎", -- this should be omitted if indicator style is not 'icon'
			-- style = "none",
		},
        separator_style = "thin", -- thin | slant | padded_slant | thick
		buffer_close_icon = "",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left", separator = false} },
		diagnostics = "coc",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "(" .. count .. ")"
		end,
	},
})

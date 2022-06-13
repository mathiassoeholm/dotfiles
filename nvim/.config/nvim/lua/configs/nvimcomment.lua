require("nvim_comment").setup({
	hook = function()
		local result = require("ts_context_commentstring.internal").update_commentstring()
	end,
})

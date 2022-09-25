vim.keymap.set("n", "<leader>j", ':lua require"jester".run()<CR>')

local function Compile(packerUse)
	packerUse("David-Kunz/jester")
end
return { Compile = Compile }

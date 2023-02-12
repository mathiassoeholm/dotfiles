local projects = {}
local function register(path, project)
	projects[path] = project
end

register("project-grim", require("projects.grim"))

local currentPath = vim.fn.getcwd()
local activeProject
for path, project in pairs(projects) do
	if string.find(currentPath, path, nil, true) then
		if activeProject then
			error("Multiple projects found for path: " .. currentPath)
		end

		activeProject = project
	end
end

local buildFunction
if activeProject ~= nil then
	local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

	buildFunction = function()
		if string.find(currentPath, "project-grim", nil, true) then
			local notification
			local done = false
			local spinner_index = 1

			local function update_notification()
				notification = vim.notify("", "info", {
					title = "Pushing code",
					timeout = 1000,
					icon = done and "" or spinner_frames[spinner_index],
					replace = notification,
				})

				spinner_index = (spinner_index + 1) % #spinner_frames

				if not done then
					vim.defer_fn(update_notification, 100)
				end
			end

			update_notification()

			vim.fn.jobstart("yarn grim push:code:wait", {
				on_exit = function()
					done = true
				end,
			})
		end
	end
else
	buildFunction = function()
		vim.notify("No project found for path: " .. currentPath, "error")
	end
end

vim.api.nvim_create_user_command("Build", buildFunction, {})
vim.api.nvim_set_keymap("n", "<leader>bb", ":Build<CR>", { noremap = true, silent = true })

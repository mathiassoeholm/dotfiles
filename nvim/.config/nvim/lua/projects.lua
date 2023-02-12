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
	buildFunction = function()
		if string.find(currentPath, "project-grim", nil, true) then
			local notification
			local state = "running"
			local spinner_index = 1
			local error = ""

			local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
			local function get_notify_config()
				if state == "running" then
					return { type = "info", title = "Building", icon = spinner_frames[spinner_index] }
				elseif state == "success" then
					return { type = "info", title = "Successfully Built", icon = "" }
				elseif state == "failure" then
					return { type = "error", title = "Build Failed", icon = "", body = error, timeout = 5000 }
				end
			end

			local function update_notification()
				local config = get_notify_config()
				notification = vim.notify(config.body or "", config.type, {
					title = config.title,
					timeout = config.timeout or 1000,
					icon = config.icon,
					replace = notification,
				})

				spinner_index = (spinner_index + 1) % #spinner_frames

				if state == "running" then
					vim.defer_fn(update_notification, 100)
				end
			end

			update_notification()

			vim.fn.jobstart("yarn grim push:code:wait", {
				on_exit = function(_, code)
					state = code == 0 and "success" or "failure"
				end,
				stdout_buffered = true,
				on_stderr = function(_, data)
					error = error .. table.concat(data, "\n")
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

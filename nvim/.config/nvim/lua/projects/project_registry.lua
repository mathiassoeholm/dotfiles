local M = {}

local projects = {}

M.set = function(path, project)
	projects[path] = project
end

M.get_active_project = function()
	local result = {}

	local current_path = vim.fn.getcwd()
	local active_project
	for path, project in pairs(projects) do
		if string.find(current_path, path, nil, true) then
			if active_project then
				error("Multiple projects found for path: " .. current_path)
			end

			active_project = project
		end
	end

	if active_project ~= nil then
		result.build = function()
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

			vim.fn.jobstart(active_project.build_command, {
				on_exit = function(_, code)
					state = code == 0 and "success" or "failure"
				end,
				stdout_buffered = true,
				on_stderr = function(_, data)
					error = error .. table.concat(data, "\n")
				end,
			})
		end
	else
		result.build = function()
			vim.notify("No project found for path: " .. current_path, "error")
		end
	end

	return result
end

return M

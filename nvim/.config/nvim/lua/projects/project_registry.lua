local util = require("util")

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
			util.run_job_with_notification({
				command = active_project.build_command,
				title = function(state)
					if state == "success" then
						return "Successfully built"
					elseif state == "failure" then
						return "Build Failed"
					end

					return "Building"
				end
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

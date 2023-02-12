local M = {}

M.run_job_with_notification = function(options)
	local notification
	local state = "running"
	local spinner_index = 1
	local output = ""
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

	vim.fn.jobstart(options.command, {
		stdout_buffered = true,

		on_exit = function(_, code)
			if code == 0 or options.ignore_error then
				state = "success"
			else
				state = "failure"
			end

			if options.calback then
				options.callback(output, error)
			end
		end,

		on_stdout = function(_, data)
			output = output .. table.concat(data, "\n")
		end,

		on_stderr = function(_, data)
			error = error .. table.concat(data, "\n")
		end,
	})
end

return M

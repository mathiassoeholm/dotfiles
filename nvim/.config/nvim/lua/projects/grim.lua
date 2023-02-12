local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

vim.api.nvim_create_user_command("Build", function()
	local currentPath = vim.api.nvim_buf_get_name(0)
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
			on_exit = function(_, code)
				done = true
			end,
		})
	end
end, {})

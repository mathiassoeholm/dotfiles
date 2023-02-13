local util = require("util")
local trouble_util = require("trouble.util")

local M = {}

local function gather_tsc_results(results, callback)
	if M.ts_config_path == "" then
		vim.notify(
			"No tsconfig.json file found in path of current buffer, cannot type-check",
			"error",
			{ title = "Failed to Type-check" }
		)
		return
	end

	local command = "yarn --silent tsc --noEmit --pretty false --project " .. M.ts_config_path .. " | tsc-output-parser"

	util.run_job_with_notification({
		command = command,

		callback = function(output)
			local rawItems = vim.json.decode(output)
			for _, error in ipairs(rawItems) do
				local item = {
					bufnr = vim.fn.bufnr(error.value.path.value, true),
					lnum = error.value.cursor.value.line - 1,
					end_lnum = error.value.cursor.value.line - 1,
					col = error.value.cursor.value.col - 1,
					end_col = error.value.cursor.value.col - 1,
					severity = 1,
					message = error.value.message.value,
					code = error.value.tsError.value.errorString,
				}

				table.insert(results, trouble_util.process_item(item))
			end

			callback(results)
		end,

		title = function(state)
			if state == "success" then
				return "Successfully Type-checked"
			elseif state == "failure" then
				return "Failed to Type-check"
			end

			return "Type-checking"
		end,
	})
end

local function gather_eslint_results(results, callback)
	if M.eslint_config_path == "" then
		vim.notify(
			"No .eslintrc.cjs file found in path of current buffer, cannot lint",
			"error",
			{ title = "Failed to Lint" }
		)
		return
	end

	local directory = vim.fn.fnamemodify(M.eslint_config_path, ":h")

	local command = "yarn --silent eslint -f json " .. directory

	util.run_job_with_notification({
		command = command,

		callback = function(output)
			local files = vim.json.decode(output)

			for _, file in ipairs(files) do
				for _, message in ipairs(file.messages) do
					local item = {
						bufnr = vim.fn.bufnr(file.filePath, true),
						lnum = message.line - 1,
						col = message.column - 1,
						end_lnum = message.endLine - 1,
						end_col = message.endColumn - 1,
						severity = message.severity,
						message = message.message,
						code = message.ruleId,
					}

					table.insert(results, trouble_util.process_item(item))
				end
			end

			callback(results)
		end,

		title = function(state)
			if state == "success" then
				return "Successfully Linted"
			elseif state == "failure" then
				return "Failed to Lint"
			end

			return "Linting"
		end,
	})
end

function M.diagnose()
	-- Cache the tsconfig and eslint config paths before the Trouble buffer opens.
	local buffer_path = vim.fn.expand("%:p")
	M.ts_config_path = vim.fn.findfile("tsconfig.json", buffer_path .. ".;")
	M.eslint_config_path = vim.fn.findfile(".eslintrc.cjs", buffer_path .. ".;")

	-- Open Trouble and start result gathering
	require("trouble").open("tsc_eslint")
end

M.tsc_and_eslint = function(_, _, callback, _)
	local results = {}

	-- Start result gathering
	gather_tsc_results(results, callback)
	gather_eslint_results(results, callback)
end

local trouble_providers = require("trouble.providers").providers
trouble_providers.tsc_eslint = M.tsc_and_eslint

return M

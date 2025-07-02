return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"github/copilot.vim",
	},
	config = function()
		-- Helper function to add to the configuration
		local function get_selected_or_entire_file(context)
			local actions = require("codecompanion.helpers.actions")

			-- Check if in visual mode (CodeCompanion should provide this in context)
			local is_visual_selection = context.mode and (context.mode:find("v") or context.mode:find("V"))

			-- If not in visual mode, get the entire file content
			if not is_visual_selection then
				local bufnr = vim.api.nvim_get_current_buf()
				local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				local text = table.concat(lines, "\n")
				vim.notify("No selection detected, using entire file: " .. #text .. " chars",
					vim.log.levels.INFO)
				return text
			end

			-- If we're in visual mode, try to get the selected text
			local text = actions.get_code(context.start_line, context.end_line)

			-- Fallback if selection somehow failed
			if not text or text == "" then
				local bufnr = vim.api.nvim_get_current_buf()
				local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				text = table.concat(lines, "\n")
				vim.notify("Empty selection, falling back to entire file: " .. #text .. " chars",
					vim.log.levels.INFO)
			end

			return text
		end

		require("codecompanion").setup({
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-3.7-sonnet",
							},
						},
					})
				end,
			},
			display = {
				-- Show model name instead of "Bot" in the UI
				name = function(request)
					-- Return the model name from the request
					return request.model or "Claude" -- Default fallback if model not available
				end,

				action_palette = {
					width = 95,
					height = 10,
					prompt = "Prompt ",
					provider = "telescope",
					opts = {
						show_default_actions = true,
						show_default_prompt_library = true,
					},
				},

				-- Add customization for chat UI
				chat = {
					width = 0.7, -- Use 70% of screen width
					height = 0.8, -- Use 80% of screen height
					welcome_message = true,
					auto_focus_input = true,
					auto_size = true,
					icons = {
						user = "󰀄 ", -- User icon
						assistant = "󰚩 ", -- Assistant icon
						system = "󰏗 ", -- System icon
						error = " ", -- Error icon
					},
					spinner = {
						frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						interval = 80,
					},
				},
			},

			-- Remove keymaps section as we've centralized these
			keymaps = {},

			---- Prompt library with predefined prompts for common tasks
			prompt_library = {
				["Explain Code"] = {
					strategy = "chat", -- For straightforward explanations, prompt is sufficient
					description = "Explain the selected code in detail",
					opts = {
						short_name = "explain_code",
						auto_submit = true,
					},
					prompts = {
						{
							role = "system",
							content =
							"You are an expert code analyzer. Provide detailed explanations of code, including purpose, functionality, and important concepts or techniques used.",
						},
						-- For "Explain Code" prompt
						{
							role = "user",
							content = function(context)
								local text = get_selected_or_entire_file(context)
								return
								    "Explain the following code in detail, including its purpose, functionality, and any important concepts or techniques used:\n\n```"
								    .. context.filetype
								    .. "\n"
								    .. text
								    .. "\n```"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Review Code"] = {
					strategy = "chat", -- Code review is primarily a one-time comprehensive review
					description = "Review the selected code for improvements",
					opts = {
						short_name = "review_code",
						auto_submit = true,
					},
					prompts = {
						{
							role = "system",
							content = function(context)
								return "You are an expert "
								    .. context.filetype
								    ..
								    " developer who specializes in code review. Provide specific recommendations for improving code quality, performance, and maintainability."
							end,
						},
						{
							role = "user",
							content = function(context)
								local text = get_selected_or_entire_file(context)
								return
								    "Explain the following code in detail, including its purpose, functionality, and any important concepts or techniques used:\n\n```"
								    .. context.filetype
								    .. "\n"
								    .. text
								    .. "\n```"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Generate Tests"] = {
					strategy = "inline", -- Ideal for test generation that should be inserted directly
					description = "Generate unit tests for the selected code",
					opts = {
						short_name = "generate_tests",
						auto_submit = true,
					},
					prompts = {
						{
							role = "system",
							content = function(context)
								return "You are an expert in writing comprehensive unit tests for "
								    .. context.filetype
								    .. " code. Create thorough tests that cover normal operations, edge cases, and error scenarios."
							end,
						},
						{
							role = "user",
							content = function(context)
								local text = get_selected_or_entire_file(context)
								return "Generate comprehensive unit tests for the following code:\n\n```"
								    .. context.filetype
								    .. "\n"
								    .. text
								    .. "\n```"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Fix Issues"] = {
					strategy = "inline", -- For fixing code that should replace the selected text
					description = "Fix identified problems in the code",
					opts = {
						short_name = "fix_issues",
						auto_submit = true,
					},
					prompts = {
						{
							role = "system",
							content = function(context)
								return "You are an expert "
								    .. context.filetype
								    .. " developer who specializes in debugging and fixing code issues."
							end,
						},
						{
							role = "user",
							content = function(context)
								local text = get_selected_or_entire_file(context)
								return
								    "Identify and fix issues in the following code. Provide the improved version with explanations of what was changed and why:\n\n```"
								    .. context.filetype
								    .. "\n"
								    .. text
								    .. "\n```"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Fix Test Failures"] = {
					strategy = "chat", -- Interactive discussion about test failures is appropriate here
					description = "Fix code to address test failures",
					opts = {
						short_name = "fix_test_failures",
						auto_submit = false,
						user_prompt = true,
					},
					prompts = {
						{
							role = "system",
							content = function(context)
								return "You are an expert "
								    .. context.filetype
								    .. " developer who specializes in fixing code to pass tests."
							end,
						},
						{
							role = "user",
							content = function(context)
								local text = get_selected_or_entire_file(context)
								return
								    "The following code has failing tests. Analyze the code and test failures, then provide a fixed implementation that will pass the tests:\n\nCode:\n```"
								    .. context.filetype
								    .. "\n"
								    .. text
								    .. "\n```\n\nI will now describe the test failures:"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},

				["Scaffold Code"] = {
					strategy = "inline", -- For generating new code to be inserted
					description = "Generate scaffolding for new code",
					opts = {
						short_name = "scaffold_code",
						auto_submit = false,
						user_prompt = true,
					},
					prompts = {
						{
							role = "system",
							content = function(context)
								return "You are an expert "
								    .. context.filetype
								    .. " developer who specializes in generating clean, well-structured code scaffolding."
							end,
						},
						{
							role = "user",
							content =
							"Generate scaffolding code for the following requirement:",
							opts = {
								contains_code = false,
							},
						},
					},
				},

				["Find Code"] = {
					strategy = "chat",
					description = "Find code relevant to a specific question",
					opts = {
						short_name = "find_code", -- Discussion about finding code requires back-and-forth
						auto_submit = false,
						user_prompt = true,
					},
					prompts = {
						{
							role = "system",
							content =
							"You are an expert in analyzing codebases and finding relevant sections based on requirements or questions.",
						},
						{
							role = "user",
							content =
							"Find code in the current workspace that is relevant to the following question or requirement:",
							opts = {
								contains_code = false,
							},
						},
					},
				},
			},
		})
	end,
}

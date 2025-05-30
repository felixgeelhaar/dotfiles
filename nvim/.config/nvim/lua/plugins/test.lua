return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"fredrikaverpil/neotest-golang",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
		"thenbe/neotest-playwright",
	},
	opts = {
		adapters = {
			["neotest-golang"] = {
				dap_go_enabled = true,
			},
			["neotest-jest"] = {
				dap_node_enabled = true,
			},
			["neotest-playwright"] = {
				dap_node_enabled = true,
			},
			["neotest-vitest"] = {
				dap_node_enabled = true,
			},
		},
		status = { virtual_text = true },
		quickfix = {
			open = false,
		},
		output = {
			open_on_run = true,
			auto_close = false,
		},
	},
	config = function(_, opts)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					-- Replace newline and tab characters with space for more compact diagnostics
					local message = diagnostic.message
						:gsub("\n", " ")
						:gsub("\t", " ")
						:gsub("%s+", " ")
						:gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		-- Overseer configuration
		opts.consumers = opts.consumers or {}
		opts.consumers.overseer = require("neotest.consumers.overseer")

		if opts.adapters then
			local adapters = {}
			for name, config in pairs(opts.adapters or {}) do
				if type(name) == "number" then
					if type(config) == "string" then
						config = require(config)
					end
					adapters[#adapters + 1] = config
				elseif config ~= false then
					local adapter = require(name)
					if type(config) == "table" and not vim.tbl_isempty(config) then
						local meta = getmetatable(adapter)
						if adapter.setup then
							adapter.setup(config)
						elseif adapter.adapter then
							adapter.adapter(config)
							adapter = adapter.adapter
						elseif meta and meta.__call then
							adapter(config)
						else
							error("Adapter " .. name .. " does not support setup")
						end
					end
					adapters[#adapters + 1] = adapter
				end
			end
			opts.adapters = adapters
		end

		require("neotest").setup(opts)
	end,
	keys = {
		{
			"<leader>t",
			"",
			desc = "[T]est",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run File",
		},
		{
			"<leader>tT",
			function()
				require("neotest").run.run(vim.uv.cwd())
			end,
			desc = "Run All Test Files",
		},
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run Nearest",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle Summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "Show Output",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle Output Panel",
		},
		{
			"<leader>tS",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop",
		},
		{
			"<leader>tw",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "Toggle Watch",
		},
		{
			"<leader>dt",
			function()
				require("neotest").run.run({ suite = false, strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
	},
}

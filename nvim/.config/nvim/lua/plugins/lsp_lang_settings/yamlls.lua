return {
	settings = {
		yaml = {
			schemaStore = {
				enable = false, -- this plugin and its advanced options like `ignore`.
				url = "", -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
			},
			redhat = { telemetry = { enabled = false } },
			yaml = {
				keyOrdering = false,
				format = {
					enable = true,
				},
				validate = true,
				schemas = (function()
					local ok, schemastore = pcall(require, "schemastore")
					return ok and schemastore.yaml.schemas() or {}
				end)(),
			},
			capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			},
		},
	},
}

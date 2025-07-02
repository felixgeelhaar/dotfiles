return {
	settings = {
		json = {
			format = {
				enable = true,
			},
			schemas = (function()
				local ok, schemastore = pcall(require, "schemastore")
				return ok and schemastore.json.schemas() or {}
			end)(),
			validate = { enable = true },
		},
	},
}

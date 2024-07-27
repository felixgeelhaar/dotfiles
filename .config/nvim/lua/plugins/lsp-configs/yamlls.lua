return {
  settings = {
    yaml = {
      schemaStore = {
        enable = false, -- this plugin and its advanced options like `ignore`.
        url = '', -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
      },
      redhat = { telemetry = { enabled = false } },
      yaml = {
        keyOrdering = false,
        format = {
          enable = true,
        },
        validate = true,
        schemas = require('schemastore').yaml.schemas(),
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

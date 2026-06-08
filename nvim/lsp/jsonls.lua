local jsonls = {
    filetypes = { 'json', 'jsonc', 'json5' },
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enabled = true },
            format = { enabled = true },
        },
    },
}

return jsonls

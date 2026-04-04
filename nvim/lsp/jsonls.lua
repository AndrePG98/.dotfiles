local jsonls = {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc', 'json5' },
    before_init = function(_, config)
        config.settings.json.schemas = require('schemastore').json.schemas()
    end,
    init_options = {
        provideFormatter = true,
    },
    root_markers = { '.git' },
    settings = {
        json = {
            validate = { enabled = true },
            format = { enabled = true },
        },
    },
}

return jsonls

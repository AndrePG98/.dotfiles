local cssls = {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
    root_markers = { 'package.json', '.git' },
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
    capabilities = require('blink.cmp').get_lsp_capabilities {
        textDocument = { completion = { completionItem = { snippetSupport = true } } },
    },
}

return cssls

local cssls = {
    capabilities = require('blink.cmp').get_lsp_capabilities {
        textDocument = { completion = { completionItem = { snippetSupport = true } } },
    },
}

return cssls

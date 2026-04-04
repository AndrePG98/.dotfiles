local mason = {
    {
        'mason-org/mason.nvim',
        dependencies = {
            { 'seblyng/roslyn.nvim', opts = {} },
            { 'b0o/schemastore.nvim', lazy = true, version = false },
            { 'j-hui/fidget.nvim', opts = {} },
        },
        opts = {
            registries = {
                'github:mason-org/mason-registry',
                'github:Crashdummyy/mason-registry',
            },
        },
    },
}

return { mason }

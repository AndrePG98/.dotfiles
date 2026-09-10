local inline = {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    opts = {
        preset = 'minimal',
        options = {
            -- multilines = {
            --     enabled = true,
            --     always_show = false,
            --     severity = { vim.diagnostic.severity.ERROR },
            -- },
            use_icons_from_diagnostic = true,
            override_open_float = true,
        },
    },
}

return { inline }

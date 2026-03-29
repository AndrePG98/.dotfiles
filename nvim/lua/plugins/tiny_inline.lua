local inline = {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    opts = {
        preset = 'minimal',
        options = {
            -- Uncomment to show all diagnostics without hovering
            multilines = {
                enabled = true,
                always_show = true,
                severity = { vim.diagnostic.severity.ERROR },
            },
            use_icons_from_diagnostic = true,
            override_open_float = true,
        },
    },
}

local actions = {
    'rachartier/tiny-code-action.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        {
            'folke/snacks.nvim',
            opts = {
                terminal = {},
            },
        },
    },
    event = 'LspAttach',
    opts = {},
}

local fastaction = {
    'Chaitanyabsprip/fastaction.nvim',
    ---@type FastActionConfig
    opts = {},
}

return { inline, actions, fastaction }

local inline = {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    opts = {
        preset = 'classic',
        options = {
            use_icons_from_diagnostic = true,
            override_open_float = true,
            enable_on_select = true,
            show_all_diags_on_cursorline = true,
            sohw_diags_only_under_cursor = false,
            severity = {
                vim.diagnostic.severity.ERROR,
                vim.diagnostic.severity.WARN,
            },
        },
    },
}

local actions = {
    'rachartier/tiny-code-action.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope.nvim' },
    },
    event = 'LspAttach',
    opts = {},
}

return { inline, actions }

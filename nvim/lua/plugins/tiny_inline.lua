local inline = {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    opts = {
        preset = 'classic',
        options = {
            use_icons_from_diagnostic = true,
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

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'iceberg_dark',
            component_separators = { left = '|', right = '|' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_x = {
                'encoding',
                {
                    'filetype',
                    icon_only = true,
                },
            },
            lualine_y = {},
        },
        extensions = { 'neo-tree' },
    },
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'bwpge/lualine-pretty-path',
    },
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
            lualine_c = { 'pretty_path' },
        },
        inactive_sections = {
            lualine_c = { 'pretty_path' },
        },
        extensions = { 'neo-tree' },
    },
}

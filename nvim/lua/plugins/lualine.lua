local lualine = {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'bwpge/lualine-pretty-path',
    },
    opts = {
        options = {
            theme = 'everforest',
            component_separators = { left = '|', right = '|' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_c = {
                'pretty_path',
            },
            lualine_x = {
                'encoding',
                {
                    'filetype',
                    icon_only = true,
                },
            },
            lualine_y = {},
        },
        inactive_sections = {
            lualine_c = { 'pretty_path' },
        },
    },
}

return { lualine }

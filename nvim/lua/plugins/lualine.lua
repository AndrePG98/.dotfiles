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
                {
                    function()
                        return ''
                    end,
                    color = function()
                        local status = require('sidekick.status').get()
                        if status then
                            return status.kind == 'Error' and 'DiagnosticError' or status.busy and 'DiagnosticWarn' or 'Special'
                        end
                    end,
                    cond = function()
                        local status = require 'sidekick.status'
                        return status.get() ~= nil
                    end,
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

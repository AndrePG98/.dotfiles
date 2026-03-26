local trouble = {
    'folke/trouble.nvim',
    ---@class trouble.Config
    opts = {
        symbols = {
            focus = true,
        },
        icons = {
            indent = {
                middle = ' ',
                last = ' ',
                top = ' ',
                ws = '│  ',
            },
        },
        modes = {
            dia = {
                mode = 'diagnostics',
                filter = {
                    any = {
                        buf = 0,
                        {
                            severity = vim.diagnostic.severity.ERROR,
                            function(item)
                                return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                            end,
                        },
                    },
                },
                groups = { 'filename', format = '{file_icon} {basename:Title} {count}' },
            },
        },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
        {
            '<leader>tt',
            '<cmd>Trouble dia toggle focus=true<cr>',
            desc = '[T]oggle [T]rouble',
        },
    },
}

return { trouble }

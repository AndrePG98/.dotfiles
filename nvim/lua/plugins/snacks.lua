return {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {
        ---@class snacks.dashboard.Config
        ---@field enabled? boolean
        ---@field sections snacks.dashboard.Section
        ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
        dashboard = {
            preset = {
                keys = {
                    { icon = ' ', key = 'r', desc = 'Restore Session', section = 'session' },
                    { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = ' ', key = 'c', desc = 'Change theme', action = ':Telescope colorscheme' },
                    { icon = ' ', key = 's', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                    { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
                },
            },
            sections = {
                { section = 'header' },
                { section = 'keys', gap = 1, padding = 2 },
                { icon = ' ', title = 'Projects', section = 'projects', indent = 3, padding = 2 },
                { section = 'startup' },
            },
        },
    },
}

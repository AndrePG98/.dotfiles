return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
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
        lazygit = {},
        terminal = {
            shell = vim.fn.has 'win32' == 1 and 'pwsh -NoLogo' or vim.o.shell,
            win = { style = 'terminal' },
        },
        notifier = {
            style = 'compact',
            top_down = false,
        },
        dim = {},
    },
    keys = {
        {
            '<C-\\>',
            function()
                Snacks.terminal.toggle()
            end,
            desc = 'Toggle Terminal',
            mode = { 'n', 't' },
        },
        {
            '<leader>tt',
            function()
                Snacks.terminal.toggle(nil, { count = vim.v.count1 })
            end,
            desc = '[T]oggle [T]erminal by ID',
        },
        {
            '<leader>st',
            function()
                Snacks.terminal.list()
            end,
            desc = '[S]earch [T]erminals',
        },
        {
            '<leader>tg',
            function()
                Snacks.lazygit()
            end,
            desc = '[T]oggle [G]it',
        },
        {
            '<leader>td',
            function()
                if vim.g.snacks_dim then
                    Snacks.dim.disable()
                    vim.g.snacks_dim = false
                else
                    Snacks.dim.enable()
                    vim.g.snacks_dim = true
                end
            end,
            desc = '[T]oggle [D]im',
        },
    },
}

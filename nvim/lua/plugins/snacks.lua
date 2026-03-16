local snacks = {
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
                    -- { icon = ' ', key = 'r', desc = 'Restore Session', section = 'session' },
                    -- { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
                    -- { icon = ' ', key = 'c', desc = 'Change theme', action = ':Telescope colorscheme' },
                    {
                        icon = ' ',
                        key = 'c',
                        desc = 'Config',
                        action = function()
                            vim.fn.chdir(vim.fn.stdpath 'config')
                            require('neo-tree.command').execute { reveal = true, dir = vim.fn.stdpath 'config' }
                        end,
                    },
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
        indent = {
            enabled = true,
            only_scope = true,
            animate = {
                enabled = false,
            },
        },
        scratch = {},
        input = {},
        bufdelete = {},
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
            '<leader>tg',
            function()
                Snacks.lazygit()
            end,
            desc = '[T]oggle Lazy[G]it',
        },
        {
            '<leader>td',
            function()
                Snacks.terminal.toggle('lazydocker', { win = { style = 'terminal' } })
            end,
            desc = '[T]oggle Lazy[D]ocker',
        },
        {
            '<leader>tz',
            function()
                if vim.g.snacks_dim then
                    Snacks.dim.disable()
                    vim.g.snacks_dim = false
                else
                    Snacks.dim.enable()
                    vim.g.snacks_dim = true
                end
            end,
            desc = '[T]oggle [Z]one out',
        },
        {
            '<leader>tm',
            function()
                Snacks.terminal('sqlit', {
                    win = {
                        height = 0.95,
                        width = 0.95,
                    },
                })
            end,
            desc = '[T]oggle database [M]anagement',
        },
        {
            '<leader>nn',
            function()
                Snacks.input({ prompt = 'Note name: ' }, function(name)
                    if name and name ~= '' then
                        Snacks.scratch.open { name = name }
                    else
                        Snacks.scratch.open { name = 'Scratch' }
                    end
                end)
            end,
            desc = '[N]ote open/create',
        },
        {
            '<leader>nd',
            function()
                local files = Snacks.scratch.list()

                if #files == 0 then
                    vim.notify('No scratch files found', vim.log.levels.INFO)
                    return
                end

                local display = vim.tbl_map(function(f)
                    return f.name .. ' [' .. f.ft .. ']'
                end, files)

                vim.ui.select(display, { prompt = 'Delete note file:' }, function(_, idx)
                    if not idx then
                        return
                    end
                    local file = files[idx]
                    vim.fn.delete(file.file)
                    vim.notify('Deleted: ' .. file.name, vim.log.levels.INFO)
                end)
            end,
            desc = '[N]ote [D]elete',
        },
        {
            '<leader>ns',
            function()
                Snacks.scratch.select()
            end,
            desc = '[N]ote [S]elect',
        },
        {
            '<leader>q',
            function()
                Snacks.bufdelete()
            end,
            desc = '[Q]uit Current Buffer',
        },
    },
}

return { snacks }

return {
    { -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        opts = {
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.o.timeoutlen
            delay = 0,
            preset = 'modern',
            icons = { mappings = true },

            -- Document existing key chains
            spec = {
                { '<leader>s', group = '[S]earch' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>d', group = '[D]ebugger' },
                { '<leader>n', group = '[N]ote' },
                { '<leader>g', group = '[G]it' },
                { '<leader>a', group = '[A]i' },
                { 'gs', group = 'Surround' },
            },
        },
        keys = {
            {
                '<leader>?',
                function()
                    require('which-key').show { global = true }
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
    },
}

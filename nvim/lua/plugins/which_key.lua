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
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
            },
        },
        keys = {
            -- Debugger
            {
                '<leader>d',
                group = 'Debugger',
                nowait = true,
                remap = false,
            },
            {
                '<leader>db',
                function()
                    require('dap').toggle_breakpoint()
                end,
                desc = 'Toggle Breakpoint',
                nowait = true,
                remap = false,
            },
            {
                '<leader>dc',
                function()
                    require('dap').continue()
                end,
                desc = 'Continue',
                nowait = true,
                remap = false,
            },
            {
                '<leader>di',
                function()
                    require('dap').step_into()
                end,
                desc = 'Step Into',
                nowait = true,
                remap = false,
            },
            {
                '<leader>do',
                function()
                    require('dap').step_over()
                end,
                desc = 'Step Over',
                nowait = true,
                remap = false,
            },
            {
                '<leader>du',
                function()
                    require('dap').step_out()
                end,
                desc = 'Step Out',
                nowait = true,
                remap = false,
            },
            {
                '<leader>dr',
                function()
                    require('dap').repl.open()
                end,
                desc = 'Open REPL',
                nowait = true,
                remap = false,
            },
            {
                '<leader>dl',
                function()
                    require('dap').run_last()
                end,
                desc = 'Run Last',
                nowait = true,
                remap = false,
            },
            {
                '<leader>dq',
                function()
                    require('dap').terminate()
                    require('dapui').close()
                    require('nvim-dap-virtual-text').toggle()
                end,
                desc = 'Terminate',
                nowait = true,
                remap = false,
            },
            {
                '<leader>dB',
                function()
                    require('dap').list_breakpoints()
                end,
                desc = 'List Breakpoints',
                nowait = true,
                remap = false,
            },
            {
                '<leader>dt',
                function()
                    require('dapui').toggle()
                end,
                desc = 'Toggle dap ui',
                nowait = true,
                remap = false,
            },
            -- {
            --     '<leader>de',
            --     function()
            --         require('dap').set_exception_breakpoints { 'all' }
            --     end,
            --     desc = 'Set Exception Breakpoints',
            --     nowait = true,
            --     remap = false,
            -- },
        },
    },
}

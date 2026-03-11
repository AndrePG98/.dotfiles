local nvim_dap = {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'theHamsta/nvim-dap-virtual-text',
        'jay-babu/mason-nvim-dap.nvim',
        'leoluz/nvim-dap-go',
    },
    config = function()
        local mason_dap = require 'mason-nvim-dap'
        local dap = require 'dap'
        local ui = require 'dapui'
        local dap_virtual_text = require 'nvim-dap-virtual-text'
        local dap_go = require 'dap-go'

        vim.fn.sign_define('DapBreakpoint', { text = '\u{f111}', texthl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '\u{f192}', texthl = 'DapBreakpointCondition' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '\u{f10c}', texthl = 'DapBreakpointRejected' })
        vim.fn.sign_define('DapLogPoint', { text = '\u{f054}', texthl = 'DapLogPoint' })
        vim.fn.sign_define('DapStopped', { text = '\u{f0a9}', texthl = 'DapStopped', linehl = 'DapStoppedLine' })

        mason_dap.setup {
            ensure_installed = { 'delve', 'php' },
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
            },
        }

        dap.adapters = {
            php = {
                type = 'executable',
                command = 'node',
                args = { vim.fn.stdpath 'data' .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js' },
            },
        }

        dap.configurations = {
            php = {
                {
                    type = 'php',
                    request = 'launch',
                    name = 'Listen for xdebug',
                    port = 9003,
                    console = 'integratedTerminal',
                },
                {
                    type = 'php',
                    request = 'launch',
                    name = 'Launch CLI script',
                    port = 9003,
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                    runtimeExecutable = 'php',
                },
            },
        }

        dap_go.setup {
            delve = {
                path = vim.fn.has 'win32' == 1 and vim.fn.stdpath 'data' .. '\\mason\\packages\\delve\\dlv.exe' or 'dlv',
            },
        }

        dap_virtual_text.setup {
            enabled = true,
            commented = true,
            all_frames = false,
            virt_text_pos = 'eol',
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            enabled_commands = true,
        }

        ui.setup {
            layouts = {
                {
                    elements = {
                        { id = 'scopes', size = 0.65 },
                        { id = 'watches', size = 0.35 },
                    },
                    size = 45,
                    position = 'left',
                },
                {
                    elements = {
                        { id = 'console', size = 1.0 },
                    },
                    size = 12,
                    position = 'bottom',
                },
            },
            floating = {
                max_height = 0.6,
                max_width = 0.5,
                border = 'rounded',
                mappings = {
                    close = { 'q', '<Esc>' },
                },
            },
        }

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end,
    keys = {
        { '<leader>d', group = 'Debugger' },
        {
            '<leader>db',
            function()
                require('dap').toggle_breakpoint()
            end,
            desc = 'Toggle Breakpoint',
        },
        {
            '<leader>dc',
            function()
                require('dap').continue()
            end,
            desc = 'Continue',
        },
        {
            '<leader>di',
            function()
                require('dap').step_into()
            end,
            desc = 'Step Into',
        },
        {
            '<leader>do',
            function()
                require('dap').step_over()
            end,
            desc = 'Step Over',
        },
        {
            '<leader>du',
            function()
                require('dap').step_out()
            end,
            desc = 'Step Out',
        },
        {
            '<leader>dr',
            function()
                require('dap').repl.toggle()
            end,
            desc = 'Open REPL',
        },
        {
            '<leader>dl',
            function()
                require('dap').run_last()
            end,
            desc = 'Run Last',
        },
        {
            '<leader>dB',
            function()
                require('dap').list_breakpoints()
                require('telescope.builtin').quickfix(require('telescope.themes').get_dropdown {
                    previewer = false,
                })
            end,
            desc = 'List Breakpoints',
        },
        {
            '<leader>dt',
            function()
                require('dapui').toggle()
            end,
            desc = 'Toggle DAP UI',
        },
        {
            '<leader>de',
            function()
                require('dapui').eval()
            end,
            desc = 'Evaluate Expression',
            mode = { 'n', 'v' },
        },
        {
            '<leader>df',
            function()
                require('dapui').float_element()
            end,
            desc = 'Float Element',
        },

        {
            '<leader>dq',
            function()
                require('dap').terminate()
                require('dapui').close()
            end,
            desc = 'Terminate',
        },
        {
            '<leader>dX',
            function()
                require('dap').clear_breakpoints()
                vim.notify('All breakpoints cleared', vim.log.levels.INFO)
            end,
            desc = 'Clear All Breakpoints',
        },
    },
}

return { nvim_dap }

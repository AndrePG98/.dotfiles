local mason_dap = require 'mason-nvim-dap'
local dap = require 'dap'
local ui = require 'dapui'
local dap_virtual_text = require 'nvim-dap-virtual-text'
local dap_go = require 'dap-go'

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
            port = '9003',
        },
    },
}

dap_go.setup()
dap_virtual_text.setup {
    virt_text_pos = 'inline',
    commented = true,
}
ui.setup()

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

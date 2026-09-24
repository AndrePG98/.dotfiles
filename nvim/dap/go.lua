return function(dap)
    local dap_go = require 'dap-go'

    dap_go.setup {
        dap_configurations = {
            {
                type = 'go',
                name = 'Attach remote',
                mode = 'remote',
                request = 'attach',
                host = 'localhost',
                port = 2345,
                remotePath = '${workspaceFolder}',
            },
        },
        delve = {
            path = vim.fn.has 'win32' == 1 and vim.fn.stdpath 'data' .. '\\mason\\packages\\delve\\dlv.exe' or 'dlv',
        },
    }

    local dap_go_adapter = dap.adapters.go
    dap.adapters.go = function(cb, config)
        if config.mode == 'remote' then
            cb { type = 'server', host = config.host, port = config.port }
        else
            dap_go_adapter(cb, config)
        end
    end
end

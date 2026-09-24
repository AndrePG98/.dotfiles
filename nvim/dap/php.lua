return function(dap)
    local function get_local_root()
        local co = coroutine.running()
        Snacks.input({
            prompt = 'Docker remote /var/www/html maps to (blank for cwd): ',
            default = '',
            completion = 'file',
        }, function(value)
            coroutine.resume(co, value)
        end)
        local input = coroutine.yield()
        if not input or input == '' then
            return vim.fn.getcwd()
        end
        return vim.fn.expand(input)
    end

    dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { vim.fn.stdpath 'data' .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js' },
    }

    dap.configurations.php = {
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
            name = 'Listen for xdebug (Docker with /var/www/html)',
            port = 9003,
            console = 'integratedTerminal',
            pathMappings = {
                ['/var/www/html'] = get_local_root,
            },
        },
        {
            type = 'php',
            request = 'launch',
            name = 'Launch CLI script',
            port = 9003,
            program = '${file}',
            cwd = vim.fn.getcwd(),
            runtimeExecutable = 'php',
        },
    }
end

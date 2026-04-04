local function setup_lsp()
    local lsp_dir = vim.fn.stdpath 'config' .. '/lsp'
    local lsp_servers = {}

    vim.lsp.config('*', {
        capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('blink.cmp').get_lsp_capabilities()),
    })

    vim.lsp.handlers['textDocument/signatureHelp'] = function(err, result, ctx, config)
        config = vim.tbl_deep_extend('force', config or {}, {
            border = 'rounded',
            close_events = { 'CursorMoved', 'BufHidden' },
        })
        vim.lsp.handlers.signature_help(err, result, ctx, config)
    end

    if vim.fn.isdirectory(lsp_dir) == 1 then
        for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
            if file:match '%.lua$' and file ~= 'init.lua' then
                local server_name = file:gsub('%.lua$', '')
                table.insert(lsp_servers, server_name)
            end
        end
    end

    vim.lsp.enable(lsp_servers)
end

setup_lsp()

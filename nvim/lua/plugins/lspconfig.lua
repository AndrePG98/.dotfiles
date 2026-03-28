local lspconfig = {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        { 'j-hui/fidget.nvim', opts = {} },
        'saghen/blink.cmp',
        {
            'hasansujon786/nvim-navbuddy',
            dependencies = {
                'SmiteshP/nvim-navic',
                'MunifTanjim/nui.nvim',
            },
            opts = {
                window = {
                    size = '75%',
                },
            },
        },
        {
            'b0o/schemastore.nvim',
            lazy = true,
            version = false,
        },
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),

            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('<leader>f', function()
                    vim.notify('Formatting file: ' .. event.file)
                    require('conform').format { async = true, lsp_format = 'fallback', bufnr = event.buf }
                end, '[F]ormat buffer')

                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                map('grr', Snacks.picker.lsp_references, '[G]oto [R]eferences')

                -- map('gri', Snacks.picker.lsp_implementations, '[G]oto [I]mplementation')

                map('grd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                map('gri', Snacks.picker.lsp_incoming_calls, '[G]oto [I]ncoming calls')

                map('gro', Snacks.picker.lsp_outgoing_calls, '[G]oto [O]utgoing calls')

                map('grs', Snacks.picker.lsp_symbols, '[G]oto [S]ymbols')

                map('grt', Snacks.picker.lsp_type_definitions, '[G]oto [T]ype Definition')

                local function client_supports_method(client, method, bufnr)
                    return client:supports_method(method, bufnr)
                end

                vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                    border = 'rounded',
                    close_events = { 'CursorMoved', 'BufHidden' },
                })

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map('<leader>tH', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end

                if client.server_capabilities.documentSymbolProvider then
                    require('nvim-navbuddy').attach(client, event.buf)
                    require('nvim-navic').attach(client, event.buf)
                end
            end,
        })
    end,
}

return { lspconfig }

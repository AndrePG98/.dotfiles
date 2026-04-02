local lspconfig = {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'mason-org/mason.nvim',
            opts = {
                registries = {
                    'github:mason-org/mason-registry',
                    'github:Crashdummyy/mason-registry',
                },
            },
        },
        { 'j-hui/fidget.nvim', opts = {} },
        'saghen/blink.cmp',
        { 'b0o/schemastore.nvim', lazy = true, version = false },
        {
            'seblyng/roslyn.nvim',
            ---@module 'roslyn.config'
            ---@type RoslynNvimConfig
            opts = {},
        },
    },
    config = function()
        -- Set once, not on every LspAttach
        vim.lsp.handlers['textDocument/signatureHelp'] = function(err, result, ctx, config)
            config = vim.tbl_deep_extend('force', config or {}, {
                border = 'rounded',
                close_events = { 'CursorMoved', 'BufHidden' },
            })
            vim.lsp.handlers.signature_help(err, result, ctx, config)
        end

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
                map('grI', Snacks.picker.lsp_implementations, '[G]oto [I]mplementation')
                map('grd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('gri', Snacks.picker.lsp_incoming_calls, '[G]oto [I]ncoming calls')
                map('gro', Snacks.picker.lsp_outgoing_calls, '[G]oto [O]utgoing calls')
                map('grs', Snacks.picker.lsp_symbols, '[G]oto [S]ymbols')
                map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
                map('grx', vim.lsp.codelens.run, '[G]oto Code Lens run')

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then
                    return
                end

                if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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

                if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map('<leader>tH', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })
    end,
}

return { lspconfig }

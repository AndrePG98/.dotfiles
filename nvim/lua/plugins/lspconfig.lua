local lspconfig = {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        { 'j-hui/fidget.nvim', opts = {} },

        'saghen/blink.cmp',
        {
            'SmiteshP/nvim-navbuddy',
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
            'utilyre/barbecue.nvim',
            dependencies = {
                'SmiteshP/nvim-navic',
                'nvim-tree/nvim-web-devicons',
            },
            opts = {},
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

                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

                map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

                map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                ---@param client vim.lsp.Client
                ---@param method vim.lsp.protocol.Method
                ---@param bufnr? integer some lsp support methods only in specific files
                ---@return boolean
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has 'nvim-0.11' == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
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
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end

                if client and client_supports_method(client, 'textDocument/documentSymbol', event.buf) then
                    require('nvim-navbuddy').attach(client, event.buf)
                end
            end,
        })

        -- See :help vim.diagnostic.Opts
        vim.diagnostic.config {
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = true and {
                text = {
                    [vim.diagnostic.severity.ERROR] = '󰅚 ',
                    [vim.diagnostic.severity.WARN] = '󰀪 ',
                    [vim.diagnostic.severity.INFO] = '󰋽 ',
                    [vim.diagnostic.severity.HINT] = '󰌶 ',
                },
            } or {},
        }

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        -- WARN: npm install @vue/typescript-plugin --save-dev
        local vue_plugin = {
            name = '@vue/typescript-plugin',
            location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
            languages = { 'vue' },
            configNamespace = 'typescript',
        }

        local svelte_plugin = {
            name = '@typescript-svelte-plugin',
            location = vim.fn.stdpath 'data' .. '/mason/packages/svelte-language-server/node_modules/@sveltejs/ts-plugin',
            languages = { 'svelte' },
        }

        vim.lsp.config('vtsls', {
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            handlers = {
                ['textDocument/documentHighlight'] = function() end,
            },
            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = { vue_plugin, svelte_plugin },
                    },
                },
                typescript = {
                    inlayHints = {
                        parameterNames = { enabled = 'literals' },
                        parameterTypes = { enabled = true },
                        variableTypes = { enabled = true },
                        propertyDeclarationTypes = { enabled = true },
                        functionLikeReturnTypes = { enabled = true },
                        enumMemberValues = { enabled = true },
                    },
                },
            },
        })

        local css_capabilities = vim.tbl_deep_extend(
            'force',
            require('blink.cmp').get_lsp_capabilities(),
            { textDocument = { completion = { completionItem = { snippetSupport = true } } } }
        )

        vim.lsp.config('cssls', {
            capabilities = css_capabilities,
        })

        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace',
                        },
                    },
                },
            },
            omnisharp = {
                enable_roslyn_analyzers = true,
                organize_imports_on_format = true,
                enable_import_completion = true,
                keys = {
                    {
                        'grd',
                        require('omnisharp_extended').lsp_definition(),
                        '[G]oto [D]efinition',
                    },
                },
            },
            intelephense = {
                settings = {
                    telemetry = {
                        enabled = false,
                    },
                },
            },
            gopls = {
                settings = {
                    gopls = {
                        semanticTokens = true,
                        analyses = {
                            nilness = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        usePlaceholders = true,
                        completeUnimported = true,
                        directoryFilters = { '-.git', '-.vscode', '-.idea', '-node_modules', '-vendor' },
                        staticcheck = true,
                        gofumpt = true,
                        codelenses = {
                            gc_details = false,
                            generate = true,
                            regenerate_cgo = true,
                            run_govulncheck = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true,
                        },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            },
            sqls = {},
            svelte = {},
            vue_ls = {},
            vtsls = {},
            rust_analyzer = {},
            tailwindcss = {},
            jsonls = {
                filetypes = { 'json', 'jsonc', 'json5' },
                before_init = function(_, new_config)
                    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                    vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
                end,
                settings = {
                    jsonls = {
                        validate = { enabled = true },
                        format = { enabled = true },
                    },
                },
            },
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
            'gofumpt',
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }
        require('mason-lspconfig').setup {
            ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
    end,
}

return { lspconfig }

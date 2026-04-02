vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- WARN: install @vue/typescript-plugin
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

local servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    pathStrict = false,
                },
                workspace = {
                    checkThirdParty = false,
                    ignoreDir = {},
                },
                telemetry = {
                    enable = false,
                },
                completion = { callSnippet = 'Disable' },
                hint = { enable = true },
            },
        },
    },
    vtsls = {
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
    },
    svelte = {},
    vue_ls = {},
    cssls = {
        capabilities = require('blink.cmp').get_lsp_capabilities {
            textDocument = { completion = { completionItem = { snippetSupport = true } } },
        },
    },
    tailwindcss = {},
    jsonls = {
        filetypes = { 'json', 'jsonc', 'json5' },
        before_init = function(_, config)
            config.settings.json.schemas = require('schemastore').json.schemas()
        end,
        settings = {
            json = {
                validate = { enabled = true },
                format = { enabled = true },
            },
        },
    },
    intelephense = {
        settings = {
            intelephense = {
                telemetry = {
                    enabled = false,
                },
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
                usePlaceholders = false,
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
    roslyn = {},
    basedpyright = {},
}

for name, opts in pairs(servers) do
    vim.lsp.config(name, opts)
end

vim.lsp.enable(vim.tbl_keys(servers))

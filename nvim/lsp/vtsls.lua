local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'

-- WARN: install @vue/typescript-plugin
local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = mason_path .. '/vue-language-server/node_modules/@vue/language-server',
    languages = { 'vue' },
    configNamespace = 'typescript',
}

-- local svelte_plugin = {
--     name = '@typescript-svelte-plugin',
--     location = mason_path .. '/svelte-language-server/node_modules/@sveltejs/ts-plugin',
--     languages = { 'svelte' },
-- }
--#region

local vtsls = {
    cmd = { 'vtsls', '--stdio' },
    init_options = {
        hostInfo = 'neovim',
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
    root_dir = function(bufnr, on_dir)
        -- The project root is where the LSP can be started from
        -- As stated in the documentation above, this LSP supports monorepos and simple projects.
        -- We select then from the project root, which is identified by the presence of a package
        -- manager lock file.
        local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
        -- Give the root markers equal priority by wrapping them in a table
        root_markers = vim.fn.has 'nvim-0.11.3' == 1 and { root_markers, { '.git' } } or vim.list_extend(root_markers, { '.git' })
        local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
        local deno_lock_root = vim.fs.root(bufnr, { 'deno.lock' })
        local project_root = vim.fs.root(bufnr, root_markers)
        if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
            return
        end
        if deno_root and (not project_root or #deno_root >= #project_root) then
            return
        end
        on_dir(project_root or vim.fn.getcwd())
    end,
    handlers = {
        ['textDocument/documentHighlight'] = function() end,
    },
    settings = {
        vtsls = {
            tsserver = {
                -- globalPlugins = { vue_plugin, svelte_plugin },
                globalPlugins = { vue_plugin },
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
}

return vtsls

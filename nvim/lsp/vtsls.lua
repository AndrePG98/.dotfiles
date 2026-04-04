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

local vtsls = {
    settings = {
        vtsls = {
            tsserver = {
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

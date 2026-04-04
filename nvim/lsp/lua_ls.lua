local lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        { '.emmyrc.json', '.luarc.json', '.luarc.jsonc' },
        { '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' },
        { '.git' },
    },
    settings = {
        Lua = {
            codelens = {
                enable = true,
            },
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
            hint = { enable = true, semicolon = 'Disable' },
        },
    },
}

return lua_ls

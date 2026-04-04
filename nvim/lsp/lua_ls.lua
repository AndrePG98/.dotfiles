local lua_ls = {
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
}

return lua_ls

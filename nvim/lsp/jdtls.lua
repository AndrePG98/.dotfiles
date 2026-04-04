local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'

local jdtls_bundles = {
    vim.fn.glob(mason_path .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true),
}

local excluded = { 'com.microsoft.java.test.runner-jar-with-dependencies.jar', 'jacocoagent.jar' }
for _, jar in ipairs(vim.split(vim.fn.glob(mason_path .. '/java-test/extension/server/*.jar', true), '\n')) do
    if jar ~= '' and not vim.tbl_contains(excluded, vim.fn.fnamemodify(jar, ':t')) then
        table.insert(jdtls_bundles, jar)
    end
end

local function get_jdtls_cache_dir()
    return vim.fn.stdpath 'cache' .. '/jdtls'
end

local function get_jdtls_workspace_dir()
    return get_jdtls_cache_dir() .. '/workspace'
end

local root_markers1 = {
    -- Multi-module projects
    'mvnw', -- Maven
    'gradlew', -- Gradle
    'settings.gradle', -- Gradle
    'settings.gradle.kts', -- Gradle
    '.git',
}
local root_markers2 = {
    'build.xml', -- Ant
    'pom.xml', -- Maven
    'build.gradle', -- Gradle
    'build.gradle.kts', -- Gradle
}

local function get_jdtls_jvm_args()
    local env = os.getenv 'JDTLS_JVM_ARGS'
    local args = {}
    for a in string.gmatch((env or ''), '%S+') do
        local arg = string.format('--jvm-arg=%s', a)
        table.insert(args, arg)
    end
    return unpack(args)
end

local jdtls = {
    ---@param dispatchers? vim.lsp.rpc.Dispatchers
    ---@param config vim.lsp.ClientConfig
    cmd = function(dispatchers, config)
        local workspace_dir = get_jdtls_workspace_dir()
        local data_dir = workspace_dir

        if config.root_dir then
            data_dir = data_dir .. '/' .. vim.fn.fnamemodify(config.root_dir, ':p:h:t')
        end

        local config_cmd = {
            'jdtls',
            '-data',
            data_dir,
            get_jdtls_jvm_args(),
        }

        return vim.lsp.rpc.start(config_cmd, dispatchers, {
            cwd = config.cmd_cwd,
            env = config.cmd_env,
            detached = config.detached,
        })
    end,
    filetypes = { 'java' },
    root_markers = vim.fn.has 'nvim-0.11.3' == 1 and { root_markers1, root_markers2 } or vim.list_extend(root_markers1, root_markers2),
    init_options = {
        bundles = jdtls_bundles,
    },
}

return jdtls

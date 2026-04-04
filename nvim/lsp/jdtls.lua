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

local jdtls = {
    init_options = {
        bundles = jdtls_bundles,
    },
}

return jdtls

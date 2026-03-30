local home = vim.fn.expand '~'
local conform = { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
        notify_on_error = true,
        -- format_on_save = function(bufnr)
        --     -- Disable "format_on_save lsp_fallback" for languages that don't
        --     -- have a well standardized coding style. You can add additional
        --     -- languages here or re-enable it for the disabled ones.
        --     local disable_filetypes = { c = true, cpp = true }
        --     if disable_filetypes[vim.bo[bufnr].filetype] then
        --         return nil
        --     else
        --         return {
        --             timeout_ms = 500,
        --             lsp_format = 'fallback',
        --         }
        --     end
        -- end,
        formatters_by_ft = {
            lua = { 'stylua' },
            typescript = { 'prettier' },
            javascript = { 'prettier' },
            javascriptreact = { 'prettier' },
            typescriptreact = { 'prettier' },
            vue = { 'prettier' },
            html = { 'prettier' },
            json = { 'prettier' },
            jsonc = { 'prettier' },
            cs = { 'csharpier' },
            svelte = { 'prettier' },
            go = { 'goimports', 'gofumpt' },
            php = { 'pint', 'php-cs-fixer', stop_after_first = true },
            python = { 'black' },
        },
        formatters = {
            ['php-cs-fixer'] = {
                command = 'php-cs-fixer',
                args = {
                    'fix',
                    '--rules=@PSR12',
                    '$FILENAME',
                    '--using-cache=no',
                },
                stdin = false,
            },
            ['prettier'] = {
                command = vim.fn.stdpath 'data' .. '/mason/bin/prettier',
            },
        },
    },
}

return { conform }

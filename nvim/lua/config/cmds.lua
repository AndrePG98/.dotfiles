local lint_progress = function()
    local linters = require('lint').get_running()
    if #linters == 0 then
        vim.notify('No linters running', vim.log.levels.INFO)
    else
        vim.notify('Running: ' .. table.concat(linters, ', '), vim.log.levels.INFO)
    end
end

local linter_for_ft = function()
    local filetype = vim.bo.filetype
    local linters = require('lint').linters_by_ft[filetype]
    if linters and #linters > 0 then
        vim.notify('Linters for ' .. filetype .. ': ' .. table.concat(linters, ', '), vim.log.levels.INFO)
    else
        vim.notify('No linters configured for: ' .. filetype, vim.log.levels.WARN)
    end
end

vim.api.nvim_create_user_command('LintInfo', lint_progress, {})
vim.api.nvim_create_user_command('LintFt', linter_for_ft, {})

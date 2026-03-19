vim.api.nvim_create_user_command('LintInfo', function()
    local linters = require('lint').get_running()
    if #linters == 0 then
        vim.notify('No linters running', vim.log.levels.INFO)
    else
        vim.notify('Running: ' .. table.concat(linters, ', '), vim.log.levels.INFO)
    end
end, {})

vim.api.nvim_create_user_command('LintFt', function()
    local filetype = vim.bo.filetype
    local linters = require('lint').linters_by_ft[filetype]
    if linters and #linters > 0 then
        vim.notify('Linters for ' .. filetype .. ': ' .. table.concat(linters, ', '), vim.log.levels.INFO)
    else
        vim.notify('No linters configured for: ' .. filetype, vim.log.levels.WARN)
    end
end, {})

vim.api.nvim_create_user_command('SearchAndReplace', function()
    Snacks.picker.lines {
        title = 'Search',
        filter = {
            buf = true,
        },
        focus = 'input',
        args = { '--case-sensitive' },
        matcher = {
            fuzzy = false,
            smartcase = false,
            ignorecase = false,
        },
        layout = {
            hidden = { 'preview' },
        },
        confirm = function(picker)
            local search = picker.input:get()

            Snacks.picker.actions.qflist_all(picker)
            vim.cmd 'cclose'
            picker:close()

            if #vim.fn.getqflist() == 0 then
                return
            end

            Snacks.input({
                title = 'Replace with',
                prompt = ' ',
                win = {
                    relative = 'editor',
                    row = 0.65,
                    col = 0.15,
                },
            }, function(replace)
                if replace == nil then
                    return
                end

                vim.cmd('cfdo %s/\\V\\C' .. search .. '/' .. replace .. '/g | update')
                vim.cmd 'noh'
            end)
        end,
    }
end, {})

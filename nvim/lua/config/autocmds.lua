vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

local save_path = vim.fn.stdpath 'config' .. '/lua/config/colorscheme.lua'

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local name = vim.g.colors_name
        if name then
            local file = io.open(save_path, 'w')
            if file then
                file:write('vim.cmd("colorscheme ' .. name .. '")\n')
                file:close()
            end
        end
    end,
})

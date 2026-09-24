local M = {}

function M.setup(dap)
    local dap_dir = vim.fn.stdpath 'config' .. '/dap'

    if vim.fn.isdirectory(dap_dir) == 0 then
        return
    end

    for _, file in ipairs(vim.fn.readdir(dap_dir)) do
        local name = file:match '^(.+)%.lua$'
        if name then
            local path = dap_dir .. '/' .. file
            local chunk, load_err = loadfile(path)
            if not chunk then
                vim.notify('Failed to load dap config "' .. name .. '": ' .. load_err, vim.log.levels.ERROR)
            else
                local ok, server = pcall(chunk)
                if not ok then
                    vim.notify('Failed to run dap config "' .. name .. '": ' .. server, vim.log.levels.ERROR)
                elseif type(server) == 'function' then
                    server(dap)
                end
            end
        end
    end
end

return M

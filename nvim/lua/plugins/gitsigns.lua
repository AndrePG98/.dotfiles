local gitsigns = {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require 'gitsigns'

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal { ']c', bang = true }
                    else
                        gitsigns.nav_hunk 'next'
                    end
                end, { desc = 'Jump to next git [c]hange' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal { '[c', bang = true }
                    else
                        gitsigns.nav_hunk 'prev'
                    end
                end, { desc = 'Jump to previous git [c]hange' })

                -- Toggles
                map('n', '<leader>hb', gitsigns.toggle_current_line_blame, { desc = '[H]unk git show [B]lame' })
                map('n', '<leader>hs', gitsigns.preview_hunk, { desc = '[H]unk git [S]how' })
                map('n', '<leader>hd', gitsigns.diffthis, { desc = '[H]unk git [D]iff' })
            end,
        },
    },
}

return { gitsigns }

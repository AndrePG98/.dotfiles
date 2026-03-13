local map = vim.keymap.set

map('n', ';', ':', { noremap = true })
map('v', '<esc>', ':nohlsearch<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<C-a>', 'ggVG', { desc = 'Select All' })
map('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
map('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })
map('n', '<leader>Q', ':wqa<CR>', { desc = 'Quit editor', noremap = true, silent = true })
map('n', '<leader>w', ':w<CR>', { desc = 'Save buffer', noremap = true, silent = true })

map({ 'n', 'x' }, 'gra', function()
    require('tiny-code-action').code_action {}
end, { noremap = true, silent = true, desc = '[G]oto Code [A]ction' })

map('n', '<leader>ss', ':Navbuddy<CR>', { silent = true, desc = '[S]earch [S]copes' })

map('n', '<leader>st', function()
    local terminals = Snacks.terminal.list()
    if #terminals == 0 then
        vim.notify('No terminals open', vim.log.levels.WARN)
        return
    end

    local pickers = require 'telescope.pickers'
    local finders = require 'telescope.finders'
    local conf = require('telescope.config').values
    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'

    pickers
        .new(require('telescope.themes').get_dropdown { previewer = false }, {
            prompt_title = 'Terminals',
            finder = finders.new_table {
                results = terminals,
                entry_maker = function(term)
                    local title = vim.b[term.buf] and vim.b[term.buf].term_title or 'Terminal'
                    local id = term.opts and term.opts.count or term.id or '?'
                    return {
                        value = term,
                        display = string.format('%s: %s', id, title),
                        ordinal = title,
                    }
                end,
            },
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local term = action_state.get_selected_entry().value
                    term:show()
                end)
                return true
            end,
        })
        :find()
end, { desc = '[S]earch [T]erminals' })

map({ 'x', 'o' }, 'am', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
end)
map({ 'x', 'o' }, 'im', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
end)
map({ 'x', 'o' }, 'ac', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
end)
map({ 'x', 'o' }, 'ic', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
end)
-- -- You can also use captures from other query groups like `locals.scm`
-- map({ 'x', 'o' }, 'as', function()
--     require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')
-- end)

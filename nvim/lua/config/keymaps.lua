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
map('n', '<leader>w', ':w<CR>', { desc = '[W]rite buffer', noremap = true, silent = true })

map({ 'n', 'x' }, 'grA', function()
    require('tiny-code-action').code_action {}
end, { noremap = true, silent = true, desc = '[G]oto All Code [A]ction' })

map({ 'n', 'x' }, 'gra', ':lua require("fastaction").code_action()<CR>', { desc = '[G]oto cursor code [A]ctions', buffer = bufnr })

map('n', '<leader>ss', ':Navbuddy<CR>', { silent = true, desc = '[S]earch [S]copes' })

map('n', '<leader>s.', ':SearchAndReplace<CR>', { silent = true, desc = '[S]earch and replace' })

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
--

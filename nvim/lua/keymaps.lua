local map = vim.keymap.set

map('n', ';', ':', { noremap = true })
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<C-a>', 'ggVG', { desc = 'Select All' })
map('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
map('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })
map('n', '<leader>q', ':bd<CR>', { desc = 'Close buffer', noremap = true, silent = true })
map('n', '<leader>w', ':w<CR>', { desc = 'Save buffer', noremap = true, silent = true })

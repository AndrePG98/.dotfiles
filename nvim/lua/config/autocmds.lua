vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd('VimEnter', {
    nested = true,
    callback = function()
        pcall(vim.cmd.colorscheme, vim.g.SCHEME)
    end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function(params)
        vim.g.SCHEME = params.match
    end,
})

-- Treesitter syntax highlighting
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', 'php', 'lua', 'dockerfile', 'sql', 'typescript', 'javascript', 'svelte' },
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
    end,
})

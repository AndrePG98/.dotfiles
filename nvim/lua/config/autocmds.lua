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

local filetypes = { 'go', 'php', 'lua', 'dockerfile', 'sql', 'typescript', 'javascript', 'svelte', 'markdown', 'vue', 'python', 'java', 'yaml', 'json' }

-- Treesitter syntax highlighting
vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function(ev)
        local ft = vim.bo[ev.buf].filetype

        local ok, _ = pcall(vim.treesitter.get_parser, ev.buf, ft)

        if not ok then
            vim.notify('No Tree-sitter parser for ' .. ft, vim.log.levels.WARN)
            return
        end

        vim.treesitter.start(ev.buf, ft)
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'php' },
    callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'dap-view', 'dap-view-term', 'dap-repl' }, -- dap-repl is set by `nvim-dap`
    callback = function(args)
        vim.keymap.set('n', 'q', '<C-w>q', { buffer = args.buf })
    end,
})

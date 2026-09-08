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
    callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        if ft == '' then
            return
        end

        local ok, _ = pcall(vim.treesitter.get_parser, ev.buf, ft)

        if not ok then
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
    pattern = { 'dapui_scopes', 'dapui_breakpoints', 'dapui_stacks', 'dapui_watches', 'dapui_console', 'dapui_hover', 'dap-repl' }, -- dap-repl is set by `nvim-dap`
    callback = function(args)
        vim.keymap.set('n', 'q', '<C-w>q', { buffer = args.buf })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'dap-repl',
    callback = function()
        require('dap.ext.autocompl').attach()
    end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { 'docker-compose*.yml', 'docker-compose*.yaml', 'compose*.yml', 'compose*.yaml' },
    callback = function()
        vim.bo.filetype = 'yaml.docker-compose'
    end,
})

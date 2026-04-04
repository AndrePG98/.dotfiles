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

        local ok, parser = pcall(vim.treesitter.get_parser, bufnr, ft)

        if not ok then
            vim.notify('No Tree-sitter parser for ' .. ft, vim.log.levels.WARN)
            return
        end

        vim.treesitter.start(bufnr, ft)
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

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('<leader>f', function()
            vim.notify('Formatting file: ' .. event.file)
            require('conform').format { async = true, lsp_format = 'fallback', bufnr = event.buf }
        end, '[F]ormat buffer')

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('grr', Snacks.picker.lsp_references, '[G]oto [R]eferences')
        map('grI', Snacks.picker.lsp_implementations, '[G]oto [I]mplementation')
        map('grd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gri', Snacks.picker.lsp_incoming_calls, '[G]oto [I]ncoming calls')
        map('gro', Snacks.picker.lsp_outgoing_calls, '[G]oto [O]utgoing calls')
        map('grs', Snacks.picker.lsp_symbols, '[G]oto [S]ymbols')
        map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
        map('grx', vim.lsp.codelens.run, '[G]oto Code Lens run')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
            })
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>tH', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
        end
    end,
})

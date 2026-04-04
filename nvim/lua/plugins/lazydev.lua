local lazydev = {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
        library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            -- load plugin types when their global is referenced
            { path = 'snacks.nvim', words = { 'Snacks' } },
            { path = 'lazy.nvim', words = { 'LazyVim', 'Lazy' } },
            { path = 'nvim-dap-ui', words = { 'dapui' } },
            { path = 'nvim-dap', words = { 'dap' } },
            { path = 'which-key.nvim', words = { 'wk' } },
            -- always loaded (no condition)
        },
        enabled = true,
    },
}
return { lazydev }

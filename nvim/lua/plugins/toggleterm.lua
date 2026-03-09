local toggleTerm = {
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = {
            open_mapping = [[<C-\>]],
            shell = vim.fn.has 'win32' == 1 and 'pwsh -NoLogo' or vim.o.shell,
        },
    },
}

return { toggleTerm }

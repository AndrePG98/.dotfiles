local bufferline = {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            separator_style = 'slant',
            offsets = {
                { filetype = 'neo-tree', text = 'File Explorer', text_align = 'center', padding = '0', separator = true },
            },
            diagnostics = 'nvim_lsp',
        },
    },
}

return { bufferline }

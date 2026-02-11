local nvimJava = {
    'nvim-java/nvim-java',
    config = function()
        require('java').setup()
        vim.lsp.enable 'jdtls'
    end,
}

return { nvimJava }

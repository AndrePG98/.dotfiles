local nvim_dap = {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'theHamsta/nvim-dap-virtual-text',
        'jay-babu/mason-nvim-dap.nvim',
        'leoluz/nvim-dap-go',
    },
}

return { nvim_dap }

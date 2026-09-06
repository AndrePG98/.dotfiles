local treesitter = { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
}

local treesitter_textobjects = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function()
        vim.g.no_plugin_maps = true
    end,
    opts = {},
}

return { treesitter, treesitter_textobjects }

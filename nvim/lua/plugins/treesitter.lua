local treesitter = { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    opts = {
        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
    },
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

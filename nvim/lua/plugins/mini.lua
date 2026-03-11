local mini = { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 500 }

        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup {
            mappings = {
                add = 'gsa',
                delete = 'gsd',
                replace = 'gsr',
                find = 'gsf',
                find_left = 'gsF',
                highlight = 'gsh',
                update_n_lines = 'gsn',
            },
        }
        require('mini.pairs').setup()
    end,
}

return { mini }

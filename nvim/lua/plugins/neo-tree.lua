-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
        { '\\', ':Neotree reveal<CR>', desc = 'Toggle File Explorer', silent = true },
    },
    opts = {
        source_selector = {
            statusline = false,
        },
        popup_border_style = 'NC',
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
            window = {
                mappings = {
                    ['\\'] = 'close_window',
                    ['g'] = function()
                        require('neo-tree.command').execute {
                            toggle = true,
                            source = 'git_status',
                            position = 'right',
                        }
                    end,
                    ['f'] = 'fuzzy_finder',
                },
                position = 'right',
            },
        },
        git_status = {
            window = {
                mappings = {
                    ['g'] = function()
                        require('neo-tree.command').execute {
                            toggle = true,
                            source = 'filesystem',
                            position = 'right',
                        }
                    end,
                },
            },
        },
        event_handlers = {
            --{
            --  event = "neo_tree_window_before_open",
            --  handler = function(args)
            --    print("neo_tree_window_before_open", vim.inspect(args))
            --  end
            --},
            {
                event = 'neo_tree_window_after_open',
                handler = function(args)
                    if args.position == 'left' or args.position == 'right' then
                        vim.cmd 'wincmd ='
                    end
                end,
            },
            --{
            --  event = "neo_tree_window_before_close",
            --  handler = function(args)
            --    print("neo_tree_window_before_close", vim.inspect(args))
            --  end
            --},
            {
                event = 'neo_tree_window_after_close',
                handler = function(args)
                    if args.position == 'left' or args.position == 'right' then
                        vim.cmd 'wincmd ='
                    end
                end,
            },
        },
    },
}

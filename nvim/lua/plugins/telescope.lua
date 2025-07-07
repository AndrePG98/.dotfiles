local telescope = {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-tree/nvim-web-devicons', enabled = true },
        'jonarrien/telescope-cmdline.nvim',
    },
    config = function()
        require('telescope').setup {
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
                cmdline = {
                    picker = {
                        layout_config = {
                            width = 55,
                            height = 15,
                        },
                    },
                },
            },
        }

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        pcall(require('telescope').load_extension, 'themes')
        pcall(require('telescope').load_extension, 'cmdline')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
        vim.keymap.set('n', '<leader>sc', builtin.colorscheme, { desc = '[S]earch [C]olorscheme' })

        vim.keymap.set('n', '<leader>sh', function()
            builtin.help_tags {
                layout_config = {
                    width = 0.9,
                    preview_width = 0.6,
                },
                layout_strategy = 'horizontal',
            }
        end, { desc = '[S]earch [H]elp' })

        vim.keymap.set('n', '<leader>sf', function()
            builtin.find_files(require('telescope.themes').get_dropdown {
                previewer = false,
            })
        end, { desc = '[S]earch [F]iles' })

        vim.keymap.set('n', '<leader><leader>', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        vim.keymap.set('n', '<leader>/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch [/] in Open Files' })

        -- vim.keymap.set('n', '<leader>sn', function()
        --     builtin.find_files { cwd = vim.fn.stdpath 'config' }
        -- end, { desc = '[S]earch [N]eovim files' })
    end,
}

return { telescope }

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
        local actions = require 'telescope.actions'
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = {
                    'node_modules',
                    '.git/',
                    'vendor',
                },
                mappings = {
                    i = {
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-j>'] = actions.move_selection_next,
                    },
                },
            },
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
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            },
        }

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        pcall(require('telescope').load_extension, 'themes')
        pcall(require('telescope').load_extension, 'cmdline')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sK', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sR', builtin.resume, { desc = '[S]earch [R]esume last picker' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
        vim.keymap.set('n', '<leader>sC', builtin.colorscheme, { desc = '[S]earch [C]olorscheme' })

        vim.keymap.set('n', '<leader>sp', function()
            builtin.live_grep {
                layout_config = {
                    width = 0.9,
                    preview_width = 0.5,
                },
            }
        end, { desc = '[S]earch by [P]roject' })

        vim.keymap.set('n', '<leader>sd', function()
            local function grep_in_dir(dir)
                require('telescope.builtin').live_grep {
                    search_dirs = { dir },
                    layout_config = { width = 0.9, preview_width = 0.5 },
                }
            end

            -- check if neo-tree is the focused window
            local filetype = vim.bo.filetype
            if filetype == 'neo-tree' then
                local state = require('neo-tree.sources.manager').get_state 'filesystem'
                local node = state.tree:get_node()
                local path = node.path

                -- if it's a file, use its parent directory
                if node.type == 'file' then
                    path = vim.fn.fnamemodify(path, ':h')
                end

                grep_in_dir(path)
            else
                vim.ui.input({ prompt = 'Grep in directory: ', default = './', completion = 'dir' }, function(dir)
                    if dir then
                        grep_in_dir(dir)
                    end
                end)
            end
        end, { desc = '[S]earch in [D]irectory' })

        vim.keymap.set('n', '<leader>sH', function()
            builtin.help_tags {
                layout_config = {
                    width = 0.9,
                    preview_width = 0.6,
                },
                layout_strategy = 'horizontal',
            }
        end, { desc = '[S]earch [H]elp' })

        vim.keymap.set('n', '<leader>sP', function()
            vim.ui.input({ prompt = 'File pattern (e.g. *.lua): ' }, function(pattern)
                if pattern then
                    builtin.live_grep {
                        glob_pattern = pattern,
                        layout_config = {
                            width = 0.9,
                            preview_width = 0.5,
                        },
                    }
                end
            end)
        end, { desc = '[S]earch by file [P]attern' })

        vim.keymap.set('n', '<leader>sf', function()
            builtin.find_files(require('telescope.themes').get_dropdown {
                previewer = false,
            })
        end, { desc = '[S]earch [F]iles' })

        vim.keymap.set('n', '<leader><leader>', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                previewer = true,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        -- vim.keymap.set('n', '<leader>/', function()
        --     builtin.live_grep {
        --         grep_open_files = true,
        --         prompt_title = 'Live Grep in Open Files',
        --     }
        -- end, { desc = '[S]earch [/] in Open Files' })
        --
        -- vim.keymap.set('n', '<leader>sn', function()
        --     builtin.find_files { cwd = vim.fn.stdpath 'config' }
        -- end, { desc = '[S]earch [N]eovim files' })
    end,
}

return { telescope }

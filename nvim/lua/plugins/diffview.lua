local diffview = {
    'sindrets/diffview.nvim',
    opts = {
        view = {
            merge_tool = {
                layout = 'diff3_mixed',
            },
        },
        file_panel = {
            win_config = {
                position = 'right',
            },
        },
    },
}

return { diffview }

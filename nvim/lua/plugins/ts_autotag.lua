local autotag = {
    'windwp/nvim-ts-autotag',
    lazy = false,
    opts = {},
    per_filetype = {
        ["php"] = {
            enable_close = true,
        }
    }
}

return { autotag }

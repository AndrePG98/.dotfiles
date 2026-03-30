local copilot = {
    'zbirenbaum/copilot.lua',
    event = 'VimEnter',
    opts = {
        panel = {
            enabled = false,
        },
        suggestion = {
            enabled = false,
        },
        filetypes = {
            markdown = true,
            help = true,
        },
    },
}

return { copilot }

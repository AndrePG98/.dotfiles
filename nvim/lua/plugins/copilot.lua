local copilot = {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
        panel = {
            enabled = false,
        },
        suggestion = {
            enabled = false,
        },
        disable_limit_reached_message = true,
        filetypes = {
            markdown = true,
            help = true,
        },
    },
}

return { copilot }

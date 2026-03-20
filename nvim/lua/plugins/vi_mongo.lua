local viMongo = {
    'kopecmaciej/vi-mongo.nvim',
    config = function()
        require('vi-mongo').setup {
            persist = false, -- default: false; set to true to persist the connection between float window sessions
        }
    end,
    cmd = { 'ViMongo' },
    keys = {
        { '<leader>tM', '<cmd>ViMongo<cr>', desc = '[T]oggle [M]ongo' },
    },
}

return { viMongo }

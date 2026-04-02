vim.g.have_nerd_font = true
vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.o.relativenumber = true
vim.o.wrap = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.opt.termguicolors = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.fillchars = { eob = ' ' }
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

vim.opt.foldenable = true
vim.o.foldlevel = 99

vim.notify = require 'snacks.notifier'

vim.diagnostic.config {
    virtual_text = false,
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    },
}

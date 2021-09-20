vim.o.updatetime = 500
vim.o.shell = '/usr/local/bin/zsh -f' -- '/bin/bash'
-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
-- Misc
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.cmd [[set viminfo+=n~/.cache/nvim/viminfo]]
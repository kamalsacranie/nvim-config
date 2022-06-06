-- For code word highlighting
vim.o.updatetime = 500
vim.o.shell = vim.fn.getenv("HOMEBREW_PREFIX") .. "/bin/zsh"
-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
-- Automatically set pwd to buffer file path
vim.opt.autochdir = true
-- Misc
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.cmd([[set viminfo+=n~/.cache/nvim/viminfo]])
vim.opt.wrap = false
-- Setting udofile to on
vim.opt.undofile = true
-- Casing
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Fold settings
vim.opt.foldlevelstart = 9 -- All folds start open
-- Setting a cursorline
vim.opt.cursorline = true

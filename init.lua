--[[  ___          ___       ___                ___          ___       ___
     /\  \        /\  \     /\  \              /\__\        /\__\     /\  \
    /::\  \      /::\  \    \:\  \            /::|  |      /:/  /     \:\  \
   /:/\:\  \    /:/\:\  \    \:\  \          /:|:|  |     /:/  /       \:\  \
  /::\~\:\  \  /::\~\:\  \   /::\  \        /:/|:|  |__  /:/  /  ___   /::\  \
 /:/\:\ \:\__\/:/\:\ \:\__\ /:/\:\__\      /:/ |:| /\__\/:/__/  /\__\ /:/\:\__\
 \:\~\:\ \/__/\/__\:\/:/  //:/  \/__/      \/__|:|/:/  /\:\  \ /:/  //:/  \/__/
  \:\ \:\__\       \::/  //:/  /               |:/:/  /  \:\  /:/  //:/  /
   \:\ \/__/       /:/  / \/__/                |::/  /    \:\/:/  / \/__/
    \:\__\        /:/  /                       /:/  /      \::/  /
     \/__/        \/__/                        \/__/        \/__/          --]] --
-- Boostrapping Packer
local fn = vim.fn
local config = fn.getenv('XDG_CONFIG_HOME') .. '/nvim'
local pack_root = fn.stdpath('data') .. '/site/pack/packer'
local install_path = pack_root .. '/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
end
if fn.empty(fn.glob(config .. '/packer')) then
    fn.system({'ln', '-s', pack_root, config})
    vim.cmd 'packadd packer.nvim'
end

require('pre')

vim.g.python3_host_prog = '/usr/local/bin/python3.9'

vim.o.updatetime = 500
vim.o.shell = '/usr/local/bin/zsh -f' -- '/bin/bash'
vim.g.mapleader = ' '
-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

-- USEFUL NOTE: ANYTHING THAT IS IN THE plugin or after/plugin folder gets
-- sourced automagically
require('post')
vim.o.cursorline = false

-- Mapping WQ to wqa
vim.cmd [[command! -bar -bang WQ wqa<bang>]]

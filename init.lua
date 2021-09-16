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
     \/__/        \/__/                        \/__/        \/__/          --]]


-- Boostrapping Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

-- USEFUL NOTE: ANYTHING THAT IS IN THE plugin or after/plugin folder gets
-- sourced automagically

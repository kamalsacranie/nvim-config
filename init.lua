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

vim.g.mapleader = " "
-- Loading our global functions for later use in setup
require("qol_globals")
-- Installing packer if vim doesn't have it
require("utils.packer_bootstrap")
-- Setting our vanilla vim options
require("vanilla.sets")
require("vanilla.lets")
require("vanilla.mappings")
require("vanilla.autocmds")
-- Setting up our pligins
require("plugins")

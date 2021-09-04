-- My commands
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')

-- Loading all plugin configs (not sure why we can do this before we load plugins)
require('plugin-config')

-- Pakcer config
require('init')

-- Language specific things idk yet how you can conditionally load stuff yet
require('lang')

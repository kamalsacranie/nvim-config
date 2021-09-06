vim.g.mapleader = ' '
-- My commands
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')

-- Packcer config
require('init')

-- Loading all plugin configs (not sure why we can do this before we load plugins)
require('plugin-config')

-- Language specific things idk yet how you can conditionally load stuff yet
require('lang')

-- must figure out where to put. Dont know why it isnt firing when its in after. Probably have to be after plugin function run
vim.cmd [[
augroup pandoc_syntax
  autocmd! BufNewFile,BufFilePre,BufRead *.md set syntax=markdown.pandoc
augroup END
]]
vim.cmd [[
let didit = 0
autocmd! InsertEnter * if ! didit | call feedkeys("\<C-\>\<C-o>:nohlsearch|let didit = 1\<CR>", 'n') | endif
autocmd! InsertLeave * let didit = 0
]]

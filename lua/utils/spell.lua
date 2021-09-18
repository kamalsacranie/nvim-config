vim.cmd('setlocal spell spelllang=en_gb')
vim.o.spellsuggest = 'fast,20'
vim.o.spellfile = vim.env.XDG_CONFIG_HOME .. '/nvim/en.utf-8.add'

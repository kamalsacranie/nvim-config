vim.cmd("setlocal spell spelllang=en_gb")
vim.o.spellsuggest = "fast,20"
vim.o.spellfile = vim.fn.stdpath("config") .. "/en.utf-8.add"

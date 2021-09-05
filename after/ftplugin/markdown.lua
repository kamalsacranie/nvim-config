-- Setting tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
-- Setting width and colorcolumn
vim.opt.textwidth = 79
vim.opt.colorcolumn = {80}

-- Loading snippets
require("luasnip/loaders/from_vscode").lazy_load()
-- Setting up spell
require('modular-settings.spell')

vim.api.nvim_set_keymap('v', '<leader>wc', '<Esc>:WordCount<CR>gv',
                        {noremap = true})

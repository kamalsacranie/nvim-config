-- Setting tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
-- Setting width and colorcolumn
vim.opt.textwidth = 79
vim.opt.colorcolumn = {80}

-- Setting up spell
require('modular-settings.spell')

-- Keymaps
vim.api.nvim_set_keymap('n', 'gf', 'gf<C-w>o', {noremap = true})
vim.g['pandoc#hypertext#split_open_cmd'] = 'e'

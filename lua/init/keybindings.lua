-- Setting new linke while in normal mode
vim.api.nvim_set_keymap('n', 'nl', 'o<ESC>', {noremap = true})
vim.api.nvim_set_keymap('n', 'NL', 'O<ESC>', {noremap = true})

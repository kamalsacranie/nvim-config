vim.api.nvim_set_keymap('v', '<leader>yc', '\"*y', {noremap = true})
-- Setting new linke while in normal mode
vim.api.nvim_set_keymap('n', 'nl', 'o<ESC>', {noremap = true})
vim.api.nvim_set_keymap('n', 'NL', 'O<ESC>', {noremap = true})
-- Mapping alt bkspc to ctrl w in insert mode
vim.api.nvim_set_keymap('i', '<M-BS>', '<C-w>', {noremap = true})
-- Alt symbol remap
vim.api.nvim_set_keymap('i', '<M-3>', '£', {noremap = true})

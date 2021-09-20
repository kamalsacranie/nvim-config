-- Mapping WQ to wqa
vim.cmd [[command! -bar -bang WQ wqa<bang>]]
-- Yank to my system clipboard
vim.api.nvim_set_keymap('v', '<leader>yc', '\"*y', {noremap = true})
-- Remapping split nav
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', {noremap = true})
-- Yank remap to yank to end of line not whole line
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})
-- Mapping alt bkspc to ctrl w in insert mode
vim.api.nvim_set_keymap('i', '<M-BS>', '<C-w>', {noremap = true})
-- Setting new linke while in normal mode
vim.api.nvim_set_keymap('n', 'nl', 'o<ESC>', {noremap = true})
vim.api.nvim_set_keymap('n', 'NL', 'O<ESC>', {noremap = true})

-- Alt symbol remap
vim.api.nvim_set_keymap('i', '<M-3>', '£', {noremap = true})

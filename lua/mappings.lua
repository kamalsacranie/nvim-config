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
-- Buffer switch also in insert mode
vim.api.nvim_set_keymap('i', '<C-^>', '<ESC><C-^>', {noremap = true})

-- Alt symbol remap
vim.api.nvim_set_keymap('i', '<M-3>', '£', {noremap = true})

-- Centering our line in the middle of the screen
vim.api.nvim_set_keymap('n', 'j', 'jzz', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'kzz', {noremap = true})
vim.api.nvim_set_keymap('n', '{', '{zz', {noremap = true})
vim.api.nvim_set_keymap('n', '}', '}zz', {noremap = true})
vim.api.nvim_set_keymap('n', 'G', 'Gzz', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', {noremap = true})
-- Setting new linke while in normal mode
vim.api.nvim_set_keymap('n', 'nl', 'o<ESC>zz', {noremap = true})
vim.api.nvim_set_keymap('n', 'NL', 'O<ESC>zz', {noremap = true})
-- Highilighting to the end and beginning of line in visual mode
vim.api.nvim_set_keymap('v', 'W', '$h', {noremap = true})
vim.api.nvim_set_keymap('v', 'B', '0', {noremap = true})

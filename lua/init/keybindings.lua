vim.api.nvim_set_keymap('v', '<leader>yc', '\"*y', {noremap = true})
-- Setting new linke while in normal mode
vim.api.nvim_set_keymap('n', 'nl', 'o<ESC>', {noremap = true})
vim.api.nvim_set_keymap('n', 'NL', 'O<ESC>', {noremap = true})
-- Mapping alt bkspc to ctrl w in insert mode
vim.api.nvim_set_keymap('i', '<M-BS>', '<C-w>', {noremap = true})

-- Remapping split nav
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', {noremap = true})
-- Resizing splits
vim.api.nvim_set_keymap('n', '<C-M-H>', '<cmd>vertical resize +5<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<C-M-L>', '<cmd>vertical resize -5<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<C-M-J>', '<cmd>resize -5<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-M-K>', '<cmd>resize +5<CR>', {noremap = true})

-- Alt symbol remap
vim.api.nvim_set_keymap('i', '<M-3>', '£', {noremap = true})

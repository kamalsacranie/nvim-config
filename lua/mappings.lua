local opts = { noremap = true }

-- Mapping WQ to wqa
vim.cmd([[command! -bar -bang WQ wqa<bang>]])
-- Yank to my system clipboard
vim.api.nvim_set_keymap("v", "<leader>yc", '"*y', opts)
-- Remapping split nav
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", opts)
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", opts)
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", opts)
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", opts)
-- Yank remap to yank to end of line not whole line
vim.api.nvim_set_keymap("n", "Y", "y$", opts)
-- Mapping alt bkspc to ctrl w in insert mode
vim.api.nvim_set_keymap("i", "<M-BS>", "<C-w>", opts)
-- Buffer switch also in insert mode
vim.api.nvim_set_keymap("i", "<C-^>", "<ESC><C-^>", opts)
-- Keeing changed indented section highlighted
vim.api.nvim_set_keymap("v", ">", ">gv", opts)
vim.api.nvim_set_keymap("v", "<", "<gv", opts)

-- Alt symbol remap
vim.api.nvim_set_keymap("i", "<M-3>", "£", opts)

-- Centering our line in the middle of the screen
vim.api.nvim_set_keymap("n", "j", "jzz", opts)
vim.api.nvim_set_keymap("n", "k", "kzz", opts)
vim.api.nvim_set_keymap("n", "{", "{zz", opts)
vim.api.nvim_set_keymap("n", "}", "}zz", opts)
vim.api.nvim_set_keymap("n", "G", "Gzz", opts)
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", opts)
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", opts)
-- Setting new linke while in normal mode
vim.api.nvim_set_keymap("n", "nl", "o<ESC>zz", opts)
vim.api.nvim_set_keymap("n", "NL", "O<ESC>zz", opts)
-- Highilighting to the end and beginning of line in visual mode
vim.api.nvim_set_keymap("v", "W", "$", opts)
vim.api.nvim_set_keymap("v", "Q", "0", opts)
-- Stop contiguous code jumping from leaving marks
vim.api.nvim_set_keymap("n", "}", "<Cmd>keepjumps normal! }<CR>", opts)
vim.api.nvim_set_keymap("n", "{", "<Cmd>keepjumps normal! {<CR>", opts)

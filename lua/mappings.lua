local opts = { noremap = true }

-- Mapping WQ to wqa
vim.cmd([[command! -bar -bang WQ wqa<bang>]])
-- Yank to my system clipboard
vim.api.nvim_set_keymap("v", "<leader>yc", '"*y', opts)
-- Remapping split nav
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-h>", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-W><C-l>", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-W><C-j>", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-W><C-k>", opts)
-- Window resizing
vim.api.nvim_set_keymap("n", "<A-Up>", ":resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-Down>", ":resize +2<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)
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
vim.api.nvim_set_keymap("n", "<C-o>", "<C-o>zz", opts)
vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>zz", opts)
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", opts)
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", opts)
-- Setting new linke while in normal mode
vim.api.nvim_set_keymap("n", "nl", "o<ESC>zz", opts)
vim.api.nvim_set_keymap("n", "NL", "O<ESC>zz", opts)
-- Changing how our highlihgting works
vim.api.nvim_set_keymap("v", "$", "$h", opts)
vim.api.nvim_set_keymap("n", "vv", "V", opts)
vim.api.nvim_set_keymap("n", "V", "v$h", opts)
-- Stop contiguous code jumping from leaving marks
vim.api.nvim_set_keymap("n", "}", "<Cmd>keepjumps normal! }<CR>", opts)
vim.api.nvim_set_keymap("n", "{", "<Cmd>keepjumps normal! {<CR>", opts)
-- remapping so that when we use surround in insert, we autohighlight under
-- cursor
vim.api.nvim_set_keymap("n", "S", "vS", { noremap = false })

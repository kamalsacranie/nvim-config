-- Mapping WQ to wqa
vim.cmd([[command! -bar -bang WQ wqa<bang>]])
-- Yank to my system clipboard
KMAP("v", "<leader>yc", '"*y')
-- Remapping split nav
KMAP("n", "<C-H>", "<C-W><C-h>")
KMAP("n", "<C-l>", "<C-W><C-l>")
KMAP("n", "<C-j>", "<C-W><C-j>")
KMAP("n", "<C-k>", "<C-W><C-k>")
-- Window resizing
BKMAP("n", "<A-Up>", ":resize -2<CR>")
BKMAP("n", "<A-Down>", ":resize +2<CR>")
BKMAP("n", "<A-Left>", ":vertical resize -2<CR>")
BKMAP("n", "<A-Right>", ":vertical resize +2<CR>")
-- Yank remap to yank to end of line not whole line
KMAP("n", "Y", "y$")
-- Buffer switch also in insert mode
KMAP("i", "<C-^>", "<ESC><C-^>")
-- Keeing changed indented section highlighted
KMAP("v", ">", ">gv")
KMAP("v", "<", "<gv")

-- Centering our line in the middle of the screen
KMAP("n", "j", "jzz")
KMAP("n", "k", "kzz")
KMAP("n", "{", "{zz")
KMAP("n", "}", "}zz")
KMAP("n", "G", "Gzz")
KMAP("n", "<C-o>", "<C-o>zz")
KMAP("n", "<C-i>", "<C-i>zz")
KMAP("n", "<C-d>", "<C-d>zz")
KMAP("n", "<C-u>", "<C-u>zz")
-- Setting new linke while in normal mode
KMAP("n", "nl", "o<ESC>zz")
KMAP("n", "NL", "O<ESC>zz")
-- Changing how our highlihgting works
KMAP("v", "$", "$h")
KMAP("n", "vv", "V")
KMAP("n", "V", "v$h")
-- Stop contiguous code jumping from leaving marks
KMAP("n", "}", "<Cmd>keepjumps normal! }<CR>")
KMAP("n", "{", "<Cmd>keepjumps normal! {<CR>")
-- remapping so that when we use surround in insert, we autohighlight under
-- cursor
KMAP("n", "S", "vS", { noremap = false })

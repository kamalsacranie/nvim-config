-- remapping leader to space
kmap("", "<Space>", "<Nop>")
vim.g.mapleader = " " -- I know these are technically options, but I'd argue they are mappings
vim.g.maplocalleader = " "
-- Mapping WQ to wqa
vim.cmd([[command! -bar -bang WQ wqa<bang>]])
-- Yank to my system clipboard
kmap("v", "<leader>yc", '"*y')
-- Remapping split nav
kmap("n", "<C-h>", "<C-W><C-h>")
kmap("n", "<C-l>", "<C-W><C-l>")
kmap("n", "<C-j>", "<C-W><C-j>")
kmap("n", "<C-k>", "<C-W><C-k>")
-- Window resizing
kmap("n", "<A-Up>", ":resize -2<CR>")
kmap("n", "<A-Down>", ":resize +2<CR>")
kmap("n", "<A-Left>", ":vertical resize -2<CR>")
kmap("n", "<A-Right>", ":vertical resize +2<CR>")

-- moving lines around in visual mode
kmap("v", "<C-n>", ":m '>+1<CR>gv=gv")
kmap("v", "<C-p>", ":m '<-2<CR>gv=gv")

-- Yank remap to yank to end of line not whole line
kmap("n", "Y", "y$")
-- Buffer switch also in insert mode
kmap("i", "<C-^>", "<ESC><C-^>")
-- Keeing changed indented section highlighted
kmap("v", ">", ">gv")
kmap("v", "<", "<gv")
kmap("v", "~", "~gv")

-- Centering our line in the middle of the screen
kmap("n", "j", "jzz")
kmap("n", "k", "kzz")
kmap("n", "{", "{zz")
kmap("n", "}", "}zz")
kmap("n", "G", "Gzz")
kmap("n", "<C-o>", "<C-o>zz")
kmap("n", "<C-i>", "<C-i>zz")
kmap("n", "<C-d>", "<C-d>zz")
kmap("n", "<C-u>", "<C-u>zz")
-- Setting new line while in normal mode
kmap("n", "ml", "o<ESC>zz")
kmap("n", "ML", "O<ESC>zz")
-- Changing how our highlihgting works
kmap("v", "$", "$h")
kmap("n", "vv", "V")
kmap("n", "V", "v$h")
-- Stop contiguous code jumping from leaving marks
kmap("n", "}", "<Cmd>keepjumps normal! }<CR>")
kmap("n", "{", "<Cmd>keepjumps normal! {<CR>")
-- remapping so that when we use surround in insert, we autohighlight under
-- cursor
kmap("n", "S", "vS", { noremap = false })
-- Making it easier to source files. SHOUT OUT % BABAYYYYY1
kmap("n", "<leader><leader>x", "<Cmd>w | so %<CR>")
vim.keymap.set({ "n" }, "<C-w>/", "<C-w>|<C-w>_")

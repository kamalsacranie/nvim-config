-- Mapping WQ to wqa
vim.cmd([[command! -bar -bang WQ wqall<bang>]])
---@type Keymap[]
return {
    -- Yank to my system clipboard
    { modes = "v", lhs = "<leader>yc",        rhs = '"*y' },
    -- Remapping split nav
    { modes = "n", lhs = "<C-h>",             rhs = "<C-W><C-h>" },
    { modes = "n", lhs = "<C-l>",             rhs = "<C-W><C-l>" },
    { modes = "n", lhs = "<C-j>",             rhs = "<C-W><C-j>" },
    { modes = "n", lhs = "<C-k>",             rhs = "<C-W><C-k>" },
    -- Window resizing
    { modes = "n", lhs = "<A-Up>",            rhs = ":resize -2<CR>" },
    { modes = "n", lhs = "<A-Down>",          rhs = ":resize +2<CR>" },
    { modes = "n", lhs = "<A-Left>",          rhs = ":vertical resize -2<CR>" },
    { modes = "n", lhs = "<A-Right>",         rhs = ":vertical resize +2<CR>" },
    -- moving lines around in visual mode
    { modes = "v", lhs = "<C-p>",             rhs = ":m '<-2<CR>gv=gv" },
    { modes = "v", lhs = "<C-n>",             rhs = ":m '>+1<CR>gv=gv" },
    -- Yank remap to yank to end of line not whole line
    { modes = "n", lhs = "Y",                 rhs = "y$" },
    -- Buffer switch also in insert mode
    { modes = "i", lhs = "<C-^>",             rhs = "<ESC><C-^>" },
    -- Keeing changed indented section highlighted
    { modes = "v", lhs = ">",                 rhs = ">gv" },
    { modes = "v", lhs = "<",                 rhs = "<gv" },
    { modes = "v", lhs = "~",                 rhs = "~gv" },

    -- Centering our line in the middle of the screen
    { modes = "n", lhs = "j",                 rhs = "jzz" },
    { modes = "n", lhs = "k",                 rhs = "kzz" },
    { modes = "n", lhs = "G",                 rhs = "Gzz" },
    { modes = "n", lhs = "<C-o>",             rhs = "<C-o>zz" },
    { modes = "n", lhs = "<C-i>",             rhs = "<C-i>zz" },
    { modes = "n", lhs = "<C-d>",             rhs = "<C-d>zz" },
    { modes = "n", lhs = "<C-u>",             rhs = "<C-u>zz" },
    -- Setting new line while in normal mode
    { modes = "n", lhs = "ml",                rhs = "o<ESC>zz" },
    { modes = "n", lhs = "ML",                rhs = "O<ESC>zz" },
    -- Changing how our highlihgting works
    -- { "v", "$",                 "$h" },
    -- { "n", "vv",                "V" },
    { modes = "n", lhs = "vv",                rhs = [[v$h]] },
    -- Stop contiguous code jumping from leaving marks
    { modes = "n", lhs = "}",                 rhs = "<Cmd>keepjumps normal! }<CR>zz" },
    { modes = "n", lhs = "{",                 rhs = "<Cmd>keepjumps normal! {<CR>zz" },
    -- remapping so that when we use surround in insert, we autohighlight under
    -- cursor
    { modes = "n", lhs = "S",                 rhs = "vS",                            { noremap = false } },
    -- Making it easier to source files. SHOUT OUT % BABAYYYYY1
    { modes = "n", lhs = "<leader><leader>x", rhs = "<Cmd>w | so %<CR>" },
    { modes = "n", lhs = "<C-w>/",            rhs = "<C-w>|<C-w>_" },
    -- Going to end of line. perhaps we can see if we can make it soe that we go to the end of the next delimitor
    { modes = "i", lhs = "<C-L>",             rhs = "<C-o>$" },
    -- Replicate highlight down
    { modes = "v", lhs = "<C-j>",             rhs = ":co '><CR>V'[=gv" },
}

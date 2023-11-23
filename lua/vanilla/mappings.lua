-- mappings only get set once on entry so like, if we were to make them buffer specific, we would need to reset them with an autocmd everytime

-- remapping leader to space
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " " -- I know these are technically options, but I'd argue they are mappings
vim.g.maplocalleader = " "
-- Mapping WQ to wqa
vim.cmd([[command! -bar -bang WQ wqa<bang>]])
---@type Keymap[]
local mappings = {
    -- Yank to my system clipboard
    { "v", "<leader>yc",        '"*y' },
    -- Remapping split nav
    { "n", "<C-h>",             "<C-W><C-h>" },
    { "n", "<C-l>",             "<C-W><C-l>" },
    { "n", "<C-j>",             "<C-W><C-j>" },
    { "n", "<C-k>",             "<C-W><C-k>" },
    -- Window resizing
    { "n", "<A-Up>",            ":resize -2<CR>" },
    { "n", "<A-Down>",          ":resize +2<CR>" },
    { "n", "<A-Left>",          ":vertical resize -2<CR>" },
    { "n", "<A-Right>",         ":vertical resize +2<CR>" },

    -- moving lines around in visual mode
    { "v", "<C-n>",             ":m '>+1<CR>gv=gv" },
    { "v", "<C-p>",             ":m '<-2<CR>gv=gv" },

    -- Yank remap to yank to end of line not whole line
    { "n", "Y",                 "y$" },
    -- Buffer switch also in insert mode
    { "i", "<C-^>",             "<ESC><C-^>" },
    -- Keeing changed indented section highlighted
    { "v", ">",                 ">gv" },
    { "v", "<",                 "<gv" },
    { "v", "~",                 "~gv" },

    -- Centering our line in the middle of the screen
    { "n", "j",                 "jzz" },
    { "n", "k",                 "kzz" },
    { "n", "{",                 "{zz" },
    { "n", "}",                 "}zz" },
    { "n", "G",                 "Gzz" },
    { "n", "<C-o>",             "<C-o>zz" },
    { "n", "<C-i>",             "<C-i>zz" },
    { "n", "<C-d>",             "<C-d>zz" },
    { "n", "<C-u>",             "<C-u>zz" },
    -- Setting new line while in normal mode
    { "n", "ml",                "o<ESC>zz" },
    { "n", "ML",                "O<ESC>zz" },
    -- Changing how our highlihgting works
    { "v", "$",                 "$h" },
    { "n", "vv",                "V" },
    { "n", "V",                 "v$h" },
    -- Stop contiguous code jumping from leaving marks
    { "n", "}",                 "<Cmd>keepjumps normal! }<CR>" },
    { "n", "{",                 "<Cmd>keepjumps normal! {<CR>" },
    -- remapping so that when we use surround in insert, we autohighlight under
    -- cursor
    { "n", "S",                 "vS",                          { noremap = false } },
    -- Making it easier to source files. SHOUT OUT % BABAYYYYY1
    { "n", "<leader><leader>x", "<Cmd>w | so %<CR>" },
    { "n", "<C-w>/",            "<C-w>|<C-w>_" },
    -- Going to end of line. perhaps we can see if we can make it soe that we go to the end of the next delimitor
    { "i", "<C-l>",             "<C-o>$" },
}

require("utils.helpers").map_keymap_list(mappings)

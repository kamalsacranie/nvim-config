---@type TermCreateArgs
local lg_term_cfg = {
    cmd = "lazygit",
    direction = "float",
    close_on_exit = true,
    name = "LazyGit",
    dir = "git_dir",
    display_name = "LazyGit",
    on_open = function() end,
}

---@type Keymap[]
return {
    general = {
        { "n", "<leader>lg", function()
            local t = require("toggleterm.terminal").Terminal:new(lg_term_cfg)
            t:toggle()
        end }
    },
    terminal = {
        { "t", "<C-h>", function() vim.cmd [[wincmd h]] end },
        { "t", "<C-j>", function() vim.cmd [[wincmd j]] end },
        { "t", "<C-k>", function() vim.cmd [[wincmd k]] end },
        { "t", "<C-l>", function() vim.cmd [[wincmd l]] end }
    },
}

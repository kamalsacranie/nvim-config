local telezones = require("plugins.telescope.telezones")

---@type Keymap[]
return {
    { modes = "n", lhs = "<leader>ff", rhs = function()
        telezones.find_files({ cwd = vim.fn.getcwd() })
    end },
    { modes = "n", lhs = "<leader>fF", rhs = function()
        telezones.find_files({
            cwd = require("utils.helpers").root_directory_from_patterns(
                ".git"
            ),
        })
    end },
    { modes = "n", lhs = "<leader>fh", rhs = require("telescope.builtin").help_tags },
    { modes = "n", lhs = "<leader>fg", rhs = telezones.live_grep },
    { modes = "n", lhs = "<leader>fb", rhs = require("telescope.builtin").buffers },
    { modes = "n", lhs = "<leader>fv", rhs = telezones.nvim_config },
    { modes = "n", lhs = "<leader>fk", rhs = require("telescope.builtin").keymaps },
    { modes = "n", lhs = "<leader>fs", rhs = require("plugins.telescope.telezones").doc_symbols },
    { modes = "n", lhs = "<C-g>",      rhs = function() pcall(require("telescope.builtin").git_files) end },
}

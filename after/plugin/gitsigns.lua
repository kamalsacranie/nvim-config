local opts = { noremap = true }

local set_keymap = function(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

set_keymap("n", "<leader>ghs", "<Cmd>lua require'gitsigns'.stage_hunk()<CR>")
set_keymap("v", "<leader>ghs", "<Cmd>lua require'gitsigns'.stage_hunk()<CR>")

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		mappings = { n = { ["q"] = actions.close } },
		selection_caret = "淪",
	},
})

-- Keymappings: f for find
-- other files in cwd
vim.api.nvim_set_keymap(
	"n",
	"<leader>ff",
	"<cmd>lua require('telescope.builtin').find_files()<CR>",
	{ noremap = true }
)
-- grep text in files (im guessing)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fg",
	"<cmd>lua require('telescope.builtin').live_grep()<CR>",
	{ noremap = true }
)
-- list buffers
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	"<cmd>lua require('telescope.builtin').buffers()<CR>",
	{ noremap = true }
)
-- fuzzy search helptags
vim.api.nvim_set_keymap(
	"n",
	"<leader>fh",
	"<cmd>lua require('telescope.builtin').help_tags()<CR>",
	{ noremap = true }
)
-- Git project files. very naaace
vim.api.nvim_set_keymap(
	"n",
	"<C-g>",
	"<cmd>lua require('telescope.builtin').git_files()<CR>",
	{ noremap = true }
)
-- Vimrc file searc
vim.api.nvim_set_keymap(
	"n",
	"<leader>fv",
	"<cmd>lua require('utils.telezones').search_dotfiles()<CR>",
	{ noremap = true }
)

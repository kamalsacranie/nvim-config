local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
				["<C-x>"] = actions.delete_buffer,
			},
			i = {
				["<C-x>"] = actions.delete_buffer,
				["<C-c>"] = actions.close,
				["<Esc>"] = actions.close,
			},
		},
		selection_caret = "淪",
		prompt_prefix = "❯ ",
	},
})

require("telescope").load_extension("fzf")

local find_opts =
	"{ cwd = require('telescope.utils').buffer_dir(), follow = true, hidden = true, no_ignore = true}"

-- Keymappings: f for find
-- other files in cwd
vim.api.nvim_set_keymap(
	"n",
	"<leader>ff",
	"<cmd>lua require('telescope.builtin').find_files(" .. find_opts .. ")<CR>",
	{ noremap = true }
)

-- grep text in files
vim.api.nvim_set_keymap(
	"n",
	"<leader>fg",
	"<cmd>lua require('telescope.builtin').live_grep({cwd = require('telescope.utils').buffer_dir()})<CR>",
	{ noremap = true }
)

-- list buffers
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	"<cmd>lua require('telescope.builtin').buffers({ignore_current_buffer = false})<CR>",
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

-- Notes search
vim.api.nvim_set_keymap(
	"n",
	"<leader>fn",
	"<cmd>lua require('utils.telezones').search_notes()<CR>",
	{ noremap = true }
)

-- Show all keymaps
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>fk",
	"<cmd>lua require('telescope.builtin').keymaps()<CR>",
	{ noremap = true }
)

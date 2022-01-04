vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<C-n>",
	"<C-n><CR>zz<C-w>p",
	{ noremap = true, silent = true }
)
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<C-p>",
	"<C-p><CR>zz<C-w>p",
	{ noremap = true, silent = true }
)

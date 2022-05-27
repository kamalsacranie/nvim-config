vim.opt.colorcolumn = "80"
vim.api.nvim_set_keymap(
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='source $VIRTUAL_ENV/bin/activate; python3 %' go_back=0<CR>",
	{ noremap = true, silent = true }
)
vim.opt.autoindent = true

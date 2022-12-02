local M = {}
-- vim.opt.colorcolumn = "80"
vim.cmd([[setlocal colorcolumn=80]])
-- vim.cmd([[filetype plugin indent off]])
bkmap(
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='source $VIRTUAL_ENV/bin/activate; python3 %' go_back=0<CR>"
)
M.ts_config_extend = {
	indent = { enable = false },
}
M.neogen_config_extend = {
	languages = {
		python = {
			template = {
				annotation_convention = "numpydoc",
			},
		},
	},
}

return M

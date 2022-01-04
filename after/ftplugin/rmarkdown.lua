require("utils.markdown-core")

vim.cmd([[augroup rmarkdown
	autocmd!
	autocmd BufEnter * exec ":UltiSnipsAddFiletypes markdown-core.rmarkdown"
augroup END]])

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>r",
	[[<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='bookdown-render.sh "%"' go_back=0<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>b",
	[[<Cmd>w<CR><Cmd>silent! TermExec direction='float' cmd='cd $(git rev-parse --show-toplevel); papis list --format "@{doc[ref]}" | pbcopy; exit'<CR>]],
	{ noremap = true, silent = true }
)

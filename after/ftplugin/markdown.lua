require("utils.markdown-core")

vim.cmd([[let b:table_mode_corner='+']])

vim.cmd([[augroup snippets
	autocmd!
	autocmd BufEnter * exec ":UltiSnipsAddFiletypes markdown-core.markdown"
augroup END]])

-- Render pdf
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>! mkdir -p output; pandoc % -o ./output/%:r.pdf<CR>",
	{ noremap = true, silent = true }
)

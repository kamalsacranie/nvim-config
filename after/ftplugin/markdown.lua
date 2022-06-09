require("utils.markdown_core")

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
	"<Cmd>w<CR><Cmd>! mkdir -p output; pandoc -dlatex_basic % -o ./output/%:r.pdf<CR>",
	{ noremap = true, silent = true }
)

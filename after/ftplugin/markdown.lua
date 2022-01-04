require("utils.markdown-core")

vim.cmd([[augroup snippets
	autocmd!
	autocmd VimEnter * exec ":UltiSnipsAddFiletypes markdown-core"
augroup END]])

-- Render pdf
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>! mkdir -p pdf_output; pandoc % -o ./pdf_output/%:r.pdf<CR>",
	{ noremap = true, silent = true }
)

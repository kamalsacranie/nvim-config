require("utils.markdown-core")

vim.cmd([[augroup snippets
	autocmd!
	autocmd VimEnter * exec ":UltiSnipsAddFiletypes markdown-core.markdown"
augroup END]])

-- Render pdf
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>! mkdir -p output; pandoc % -o ./output/%:r.pdf<CR>",
	{ noremap = true, silent = true }
)

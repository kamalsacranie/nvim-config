require("utils.markdown-core")

vim.cmd([[augroup snippets
	autocmd!
	autocmd VimEnter * exec ":UltiSnipsAddFiletypes anki.markdown-core.markdown"
augroup END]])

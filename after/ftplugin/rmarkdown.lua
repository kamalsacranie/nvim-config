require('utils.markdown-core')

vim.cmd [[augroup rmarkdown
	autocmd!
	autocmd VimEnter * exec ":UltiSnipsAddFiletypes markdown.rmarkdown"
augroup END]]


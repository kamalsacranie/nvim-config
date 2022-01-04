vim.cmd([[
augroup pandoc_syntax
  autocmd! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
]])

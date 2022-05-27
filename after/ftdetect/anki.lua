vim.cmd([[
augroup pandoc_syntax
  autocmd! BufNewFile,BufFilePre,BufRead *.anki set filetype=anki.markdown.pandoc
augroup END
]])

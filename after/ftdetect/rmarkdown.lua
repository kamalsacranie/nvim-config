vim.cmd([[
augroup pandoc_syntax
  autocmd! BufNewFile,BufFilePre,BufRead *.rmd set syntax=rmarkdown
augroup END
]])

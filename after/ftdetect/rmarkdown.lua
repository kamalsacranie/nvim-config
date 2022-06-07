vim.cmd([[
augroup pandoc_syntax
  autocmd! BufWinEnter *.rmd set syntax=rmarkdown
  autocmd! BufWinEnter *.rmd set filetype=rmarkdown
augroup END
]])

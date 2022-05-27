vim.cmd([[
augroup pandoc_syntax
  autocmd! BufNewFile,BufFilePre,BufRead *.todo set filetype=todo
augroup END
]])

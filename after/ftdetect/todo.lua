vim.cmd([[
augroup pandoc_syntax
  autocmd! BufNewFile,BufFilePre,BufRead TODO set filetype=todo
augroup END
]])

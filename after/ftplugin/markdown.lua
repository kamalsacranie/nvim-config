require('utils.markdown-core')

vim.cmd [[
augroup pandoc_syntax
  autocmd! BufNewFile,BufFilePre,BufRead *.md set syntax=markdown.pandoc
augroup END
]]

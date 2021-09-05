require('lint').linters_by_ft = {markdown = {'markdownlint'}}
vim.cmd [[au InsertLeave <buffer> lua require('lint').try_lint()]]
vim.cmd [[au BufWritePost *.md exec 'silent! !markdownlint -f %' | exec 'e' ]]
vim.opt.autoread = true

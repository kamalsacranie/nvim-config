-- Restore last cursor position
vim.cmd([[
augroup vimStartup
au!
autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif
augroup END
]])
-- Preserving our folds
vim.cmd([[
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *[^Prompt].* mkview
  autocmd BufWinEnter *[^Prompt].* silent! loadview
augroup END
]])

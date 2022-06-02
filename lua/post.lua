-- All the things that must be set right at the end
-- Ulti jump keys
vim.cmd([[
    let g:UltiSnipsJumpForwardTrigger="<c-f>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"
]])

-- Restore last cursor position
vim.cmd([[
augroup vimStartup
au!
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif
augroup END
]])

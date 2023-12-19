-- Restore last cursor position
vim.api.nvim_create_augroup("vim_startup", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = "vim_startup",
    pattern = "*",
    command = [[
        if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        exe "normal! g`\""
        endif"
    ]],
    desc = "Restore prevous cursor position on opening a file",
})

-- Preserving our folds
vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd(
    "BufWinLeave",
    {
        group = "remember_folds",
        pattern = "*.*",
        command =
        "if &buftype !=# 'terminal' | mkview | endif"
    }
)
vim.api.nvim_create_autocmd(
    "BufWinEnter",
    { group = "remember_folds", pattern = "*.*", command = "silent! loadview" }
)

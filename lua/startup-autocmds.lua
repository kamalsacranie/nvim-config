local vim_startup_augroup = vim.api.nvim_create_augroup("vim_startup", { clear = true })

return {
    { { "BufReadPost" }, {
        group = vim_startup_augroup,
        pattern = "*",
        command = [[
            if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            exe "normal! g`\""
            endif"
        ]],
        desc = "Restore prevous cursor position on opening a file",
    } },
    { { "BufWinLeave" }, {
        group = vim_startup_augroup,
        pattern = "*.*",
        command = "if &buftype !=# 'terminal' | mkview | endif",
        desc = "Saves a view of the current vindow except for terminal buffer types",
    } },
    { { "BufWinEnter" }, { group = vim_startup_augroup, pattern = "*.*", command = "silent! loadview" } },
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.kl",
    callback = function()
        vim.cmd([[set filetype=kill]])
    end,
    desc = "Kamal's intuitive linear language",
})

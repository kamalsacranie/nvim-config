vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.lp",
    callback = function()
        vim.cmd([[set filetype=lp]])
    end,
    desc = "lp file type",
})

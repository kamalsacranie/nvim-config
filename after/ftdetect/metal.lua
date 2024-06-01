vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.metal",
    callback = function()
        vim.cmd([[set filetype=metal]])
    end,
    desc = "apple metal graphics shader file type",
})

return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            highlight = { duration = 0 }
        })
    end
}

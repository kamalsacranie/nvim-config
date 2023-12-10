return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        local config = {
            highlight = { duration = 0 }
        }
        require("nvim-surround").setup(config)
    end
}

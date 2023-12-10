return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
        require("plugins.telescope.setup")
    end,
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
}

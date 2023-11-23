return {
    "jmbuhr/otter.nvim",
    config = function()
        require("plugins.writing.otter").setup()
    end,
    ft = { "markdown", "quarto" }
}

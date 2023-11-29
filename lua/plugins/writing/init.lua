return {
    {
        "jmbuhr/otter.nvim",
        config = function()
            require("plugins.writing.otter").setup()
        end,
        ft = { "markdown", "quarto" }
    },
    {
        "TobinPalmer/pastify.nvim",
        keys = require("plugins.writing.pastify").paste_keymap[2],
        config = require("plugins.writing.pastify").setup,
        ft = { "markdown", "quarto" }
    },
}

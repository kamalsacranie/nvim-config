return {
    {
        "jmbuhr/otter.nvim",
        config = function()
            require("plugins.writing.otter").setup()
        end,
        ft = { "markdown", "quarto" },
    },
    {
        "TobinPalmer/pastify.nvim",
        keys = require("plugins.writing.pastify").paste_keymap[2],
        event = "VeryLazy",
        config = require("plugins.writing.pastify").init,
        enabled = true,
        ft = { "markdown", "quarto" }
    },
    {
        "3rd/image.nvim",
        ft = { "markdown", "quarto" },
        config = require("plugins.writing.image").setup,
        event = "VeryLazy",
        build =
            "mkdir -p " ..
            vim.fn.stdpath("data") .. "/luarocks &&" .. "luarocks --tree " ..
            vim.fn.stdpath("data") ..
            "/luarocks --lua-version=5.1 install magick",
        enabled = true,
    }
}

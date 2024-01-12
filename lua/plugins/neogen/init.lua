return {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { -- supported languages
        "sh",
        "c",
        "cs",
        "cpp",
        "go",
        "java",
        "javascript",
        "javascriptreact",
        "kotlin",
        "lua",
        "php",
        "python",
        "ruby",
        "rust",
        "typescript",
        "typescriptreact",
        "vue",
    },
    config = function()
        require("neogen").setup({ snippet_engine = "luasnip" })
        require("nvim-mapper").map_keymap_list(require("plugins.neogen.mappings"))
    end,
}

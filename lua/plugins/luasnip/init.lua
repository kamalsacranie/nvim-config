return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "InsertEnter",
    config = require("plugins.luasnip.setup").setup,
    build = "make install_jsregexp",
    dependencies = { { "rafamadriz/friendly-snippets" }, { "nvim-treesitter/nvim-treesitter" } },
}

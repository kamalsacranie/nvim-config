return {
    "williamboman/mason-lspconfig.nvim",
    config = require("plugins.lsp.setup"),
    enabled = true,
    dependencies = {
        { "neovim/nvim-lspconfig",   enabled = true },
        { "williamboman/mason.nvim", enabled = true },
    }
}

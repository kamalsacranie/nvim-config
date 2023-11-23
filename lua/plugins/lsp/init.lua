return {
    "williamboman/mason-lspconfig.nvim",
    config = require("plugins.lsp.setup"),
    enabled = true,
    dependencies = {
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "creativenull/efmls-configs-nvim" },
    }
}

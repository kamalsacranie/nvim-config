return {
    "williamboman/mason-lspconfig.nvim",
    config = require("plugins.lsp.setup"),
    enabled = true,
    dependencies = {
        { "neovim/nvim-lspconfig" },
        {
            "folke/neodev.nvim",
            config = function()
                require("neodev").setup()
            end
        },
        { "williamboman/mason.nvim" },
        { "creativenull/efmls-configs-nvim" },
        { "nvim-telescope/telescope.nvim" }
    }
}

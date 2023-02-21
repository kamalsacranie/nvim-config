return {
    "neovim/nvim-lspconfig",
    config = function()
        require("user.lsp")
    end,
    dependencies = {
        "ray-x/lsp_signature.nvim",
        "b0o/schemastore.nvim",
        "j-hui/fidget.nvim",
    },
}

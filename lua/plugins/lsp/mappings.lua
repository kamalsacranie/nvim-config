---@type Keymap[]
return {
    lsp = {
        { "n", "gd", function()
            return require("telescope.builtin")
                .lsp_definitions()
        end },
        { "n", "gri", function()
            return require("telescope.builtin").lsp_implementations()
        end },
        { "n", "gD",    vim.lsp.buf.declaration },
        { "n", "grr",   vim.lsp.buf.references },
        { "n", "grn",   vim.lsp.buf.rename },
        { "i", "<C-k>", vim.lsp.buf.signature_help },
        { "n", "[d",    function() vim.diagnostic.jump({ count = -1, float = true }) end },
        { "n", "]d",    function() vim.diagnostic.jump({ count = 1, float = true }) end },
        { "n", "gh",    vim.diagnostic.open_float },
        { "n", "K",     vim.lsp.buf.hover },
        { "n", "gra",   vim.lsp.buf.code_action },
    },
    ranged_formatting = {
        { "v", "<leader>fr", require("plugins.lsp.format").ranged_format }
    }
}

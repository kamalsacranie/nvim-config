---@type Keymap[]
return {
    lsp = {
        { "n", "gd", function()
            return require("telescope.builtin").lsp_definitions()
        end },
        { "n", "gi", function()
            return require("telescope.builtin").lsp_implementations()
        end },
        { "n", "gD",          vim.lsp.buf.declaration },
        { "n", "gr", function()
            return require("telescope.builtin").lsp_references()
        end },
        { "n", "<leader>lr",  vim.lsp.buf.rename },
        { "i", "<C-k>",       vim.lsp.buf.signature_help },
        { "n", "[d",          vim.diagnostic.goto_prev },
        { "n", "]d",          vim.diagnostic.goto_next },
        { "n", "gh",          vim.diagnostic.open_float },
        { "n", "K",           vim.lsp.buf.hover },
        { "n", "<leader>lca", vim.lsp.buf.code_action },
    },
    ranged_formatting = {
        { "v", "<leader>fr", require("plugins.lsp.format").ranged_format }
    }
}

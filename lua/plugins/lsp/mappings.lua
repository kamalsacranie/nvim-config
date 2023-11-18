-- same as the signature for vim.keymap.set
return {
    { "n", "gd",          vim.lsp.buf.definition },
    { "n", "gD",          vim.lsp.buf.declaration },
    { "n", "gr",          vim.lsp.buf.references },
    { "n", "<leader>lr",  vim.lsp.buf.rename },
    { "i", "<C-k>",       vim.lsp.buf.signature_help },
    { "n", "[d",          vim.diagnostic.goto_prev },
    { "n", "]d",          vim.diagnostic.goto_next },
    { "n", "gh",          vim.diagnostic.open_float },
    { "n", "K",           require("user.mappings.lsp_map").hover_callback },
    { "n", "<leader>lca", vim.lsp.buf.code_action },
}

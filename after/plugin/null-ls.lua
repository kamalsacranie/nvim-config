local null_ls = require('null-ls')
local builtins = null_ls.builtins
null_ls.config({
    sources = {
        builtins.formatting.prettier,
        builtins.diagnostics.write_good
            .with({filetypes = {"markdown", "rmarkdown"}}),
        builtins.diagnostics.markdownlint
            .with({filetypes = {'markdown', 'rmarkdown'}}),
        builtins.formatting.black.with({extra_args = {'-l79'}}),
        builtins.diagnostics.flake8
    }
})

require('lspconfig')['null-ls'].setup({
    on_attach = require('utils.lspattatch').on_attach
})

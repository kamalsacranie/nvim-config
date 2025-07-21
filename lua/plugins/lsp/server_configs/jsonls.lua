local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    capabilities = capabilities,
    init_options = {
        provideFormatter = true
    },
    json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
    }
}

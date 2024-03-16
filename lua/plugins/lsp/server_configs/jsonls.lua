local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    capabilities = capabilities,
    json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
    },
}

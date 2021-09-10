-- -- REALLY TEMP
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.preselectSupport = true
-- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport =
--     true
-- capabilities.textDocument.completion.completionItem.tagSupport = {
--     valueSet = {1}
-- }
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = {'documentation', 'detail', 'additionalTextEdits'}
-- }
local lsp_standard_conf = require('modular-settings/general_lsp')

-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup({
    capabilities = lsp_standard_conf.make_capabilities(),
    on_attach = lsp_standard_conf.custom_lsp_attach()
})

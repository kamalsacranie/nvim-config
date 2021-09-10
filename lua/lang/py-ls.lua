-- Installed Black through pip and then execute this on a python file when we write
-- Next time, howver I think I'd use Ale to manage the installation fo Black
vim.cmd [[autocmd BufWritePre *.py Black]]

local lsp_standard_conf = require('modular-settings/general_lsp')

require('lspconfig').python.setup {
    capabilities = lsp_standard_conf.make_capabilities(),
    on_attach = lsp_standard_conf.custom_lsp_attach()
}

-- Installed Black through pip and then execute this on a python file when we write
-- Next time, howver I think I'd use Ale to manage the installation fo Black
vim.cmd [[autocmd BufWritePre *.py Black]]
require('lspconfig').python.setup {
    on_attatch = require('modular-settings/lspattatch').attach()
}

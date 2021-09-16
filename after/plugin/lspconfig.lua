if not vim.g.lspconfig then
    return
end

local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

-- This is the best practice way to setup a language server
-- you should run this function when the server ATTATCHES!!
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings
    local opts = { noremap = true, silent = true }

    -- go to definition
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = {'javascript', 'jsx', 'typescript.tsx', 'javascript.tsx', 'typescript', 'tsx', 'typescriptreact', 'javascriptreact'}
}

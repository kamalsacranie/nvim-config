if not vim.g.lspconfig then
    return
end
local nvim_lsp = require('lspconfig')

-- This is the best practice way to setup a language server
-- you should run this function when the server ATTATCHES!!
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings
    local opts = { noremap = true, silent = true }

    -- go to definition
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>fo', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('i', '<C-i>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<C-i>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>gf', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
    end
end

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = {'javascript', 'jsx', 'typescript.tsx', 'javascript.tsx', 'typescript', 'tsx', 'typescriptreact', 'javascriptreact'}
}

-- Disables virtual texs so we just use gh to show the erroe
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
    }
)

-- Making it easier to map shit
local opts = {noremap = true, silent = true}
local buf_set_keymap = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

-- Creating our local functions for general lsp config
local M = {}

function M.custom_lsp_attach(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    buf_set_keymap('n', '<leader>wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    buf_set_keymap('n', '<leader>wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    buf_set_keymap('n', '<leader>wl',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    buf_set_keymap('n', '<leader>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    buf_set_keymap('n', '<leader>e',
                   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    buf_set_keymap('n', '<leader>q',
                   '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

    -- testing
    require('lsp_signature').on_attach(require('plugin-config/lsp-signature'))

end

-- This tells the LSP what our client is capable of. I.e. snippets etc
function M.make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport =
        true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport =
        true
    capabilities.textDocument.completion.completionItem.deprecatedSupport =
        true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport =
        true
    capabilities.textDocument.completion.completionItem.tagSupport = {
        valueSet = {1}
    }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {'documentation', 'detail', 'additionalTextEdits'}
    }
end

return M

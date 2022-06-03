local M = {}
-- Making client capabilities part of our returned table because it is required
-- for our lseconfig.setup
M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.on_attach = function(client, bufnr)
    -- setting up our mappings
    require("user.mappings.lsp_map").lsp_mappings(bufnr)

    local is_loaded, signature = LOAD_PACKAGE("lsp_signature")
    if is_loaded then
        signature.on_attach(require("user.lsp.lsp_signature").cfg, bufnr)
    end

    -- Updating cmp with our capabilities
    ---@diagnostic disable-next-line: unused-local, redefined-local
    local is_loaded, cmp = LOAD_PACKAGE("cmp_nvim_lsp")
    if is_loaded then
        M.capabilities.textDocument.completion.completionItem.snippetSupport = true
        M.capabilities = cmp.update_capabilities(M.capabilities)
    end

    -- When your LSP has formatting capabilities, it has a specified command
    -- for formatting which is called with `lua vim.lsp.buf.formatting()`. This
    -- sets up format on save with an autocommand
    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
            augroup Format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()
            augroup END
        ]])
    end

    -- If the LSP has document_highlighting capabilities, then we setup an
    -- autocmd so that when we hover our cursor over a variable etc. we get the
    -- document highlighting
    if client.resolved_capabilities.document_highlight then
        -- This is detailed in the docs under helpf for document_highlight()
        vim.cmd([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=#353d46
            hi LspReferenceText cterm=bold ctermbg=red guibg=#353d46
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=#353d46
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])
    end
end

return M

local M = {}

M.on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings
    local opts = {noremap = true, silent = true}

    -- go to definition
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', 'gh',
                   '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>lca',
                   '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- setting our diagnostic popups to have a round border
    buf_set_keymap('n', ']d',
                   '<cmd>lua vim.lsp.diagnostic.goto_next({severity_limit = "Warning", popup_opts = {border = "single"}})<CR>',
                   opts)
    buf_set_keymap('n', '[d',
                   '<cmd>lua vim.lsp.diagnostic.goto_prev({severity_limit = "Warning", popup_opts = {border = "single"}})<CR>',
                   opts)
    -- buf_set_keymap('n', '<leader>lrf', '<cmd>lua vim.lsp.buf.references()<CR>',
    --                opts)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api
            .nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
    end
    require('lsp_signature').on_attach({
        bind = true,
        fix_pos = true,
        floating_window = false,
        hint_enable = true,
        padding = '',
        handler_opts = {border = 'none'},
        auto_close_after = false,
        hint_prefix = '▸ '
    }, bufnr)

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=#353d46
        hi LspReferenceText cterm=bold ctermbg=red guibg=#353d46
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=#353d46
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
            ]], false)
    end
end

return M

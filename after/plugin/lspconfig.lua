if not vim.g.lspconfig then return end

-- This is the best practice way to setup a language server
-- you should run this function when the server ATTATCHES!!
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings
    local opts = {noremap = true, silent = true}

    -- go to definition
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)

    buf_set_keymap('n', '<leader>gf', '<Cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    -- setting our diagnostic popups to have a round border
    -- buf_set_keymap('n', ']d',
    --                '<cmd>lua vim.lsp.diagnostic.goto_next({severity_limit = "Warning", popup_opts = {border = "single"}})<CR>',
    --                opts)
    -- buf_set_keymap('n', '[d',
    --                '<cmd>lua vim.lsp.diagnostic.goto_prev({severity_limit = "Warning", popup_opts = {border = "single"}})<CR>',
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

-- Disables virtual texs so we just use gh to show the erroe
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false})

-- Make the borders of the hover and signature round
vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'})
vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signatureHelp, {border = 'rounded'})

-- LspInstall setup allows us to install servers locally not globally
-- When the server is ready we attach our regular function and then any
-- options we edit the table
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        -- requireing cmp into our capabilities
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                       .protocol
                                                                       .make_client_capabilities())
    }

    if server.name == "tsserrver" then
        opts.filetypes = {
            'javascript', 'jsx', 'typescript.tsx', 'javascript.tsx',
            'typescript', 'tsx', 'typescriptreact', 'javascriptreact'
        }
    elseif server.name == "sumneko_lua" then
        -- Document formatting cant figure out how to make the capabilities known so we can use
        -- regular formatting
        vim.cmd [[
            augroup Format
                autocmd! * <buffer>
                autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
            augroup END
        ]]
    elseif server.name == "pyright" then
        opts.filetypes = {'python'}
    end

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- JSONLS via our lspinstall doesnt seem to be working
require('lspconfig').jsonls.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
                                                                   .make_client_capabilities())

}

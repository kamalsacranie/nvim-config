if not vim.g.lspconfig then return end

local on_attach = require('utils.lspattatch').on_attach

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
        vim.cmd [[
            augroup Format
                autocmd! * <buffer>
                autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
            augroup END
        ]]
    elseif server.name == "pyright" then
        opts.filetypes = {'python'}

    elseif server.name == "html" then
        opts.filetypes = {'htmldjango'}

        -- VERY TEMPORARY
    elseif server.name == "tailwindcss" then
        opts.filetypes = {'htmldjango', 'html', 'django'}
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

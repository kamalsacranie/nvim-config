-- Telling our lsp about the vim global var
-- NOTE: that we have to use the LspInstall referenced name from the plugin
-- To make sure that our config is applied
USER = vim.fn.expand('$USER')
local custom_lsp = require('modular-settings/general_lsp')

require'lspconfig'.lua.setup({
    capabilities = custom_lsp.make_capabilities(),
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    },
    on_attach = custom_lsp.custom_lsp_attach()
})

-- Setting up autoformatting
require"lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=79 --break-after-table-lb",
                    formatStdin = true
                }
            }
        }
    }
}
-- Autoformat on save
vim.cmd [[autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)]]

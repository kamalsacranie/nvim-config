return {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-lspconfig").setup_handlers(
            {
                function(server_name)
                    local _, server_cfg = load_package("plugins.lsp.server_configs." .. server_name)
                    local lsp_server = require("lspconfig")[server_name]
                    lsp_server.setup(server_cfg or {})
                end
            }
        )
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(env)
                local bufnr = env.buf
                local bufopts = { buffer = bufnr }
                vim.tbl_map(function(mapping)
                    local mode, left, right, opts = unpack(mapping)
                    vim.keymap.set(mode, left, right, vim.tbl_deep_extend("keep", opts or {}, bufopts))
                end, require("plugins.lsp.mappings"))

                local client = vim.lsp.get_client_by_id(env.data.client_id)

                -- look into how we might define a callback. perhaps in the same file as our settings,
                -- we could have keys for the capabilities with callbacks
                if client.server_capabilities.documentHighlightProvider then
                    local doc_h_augroup = vim.api.nvim_create_augroup("DocumentHighlight", { clear = true })
                    vim.api.nvim_create_autocmd("CursorHold", {
                        group = doc_h_augroup,
                        callback = function()
                            vim.lsp.buf.document_highlight()
                        end
                    })
                    vim.api.nvim_create_autocmd("CursorHoldI", {
                        group = doc_h_augroup,
                        callback = function()
                            vim.lsp.buf.document_highlight()
                        end
                    })
                    vim.api.nvim_create_autocmd("CursorMoved", {
                        group = doc_h_augroup,
                        callback = function()
                            vim.lsp.buf.clear_references()
                        end
                    })
                end
                if client.server_capabilities.completionProvider then
                    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                end
                if client.server_capabilities.definitionProvider then
                    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
                end
            end,
        })
    end,
    enabled = true,
    dependencies = {
        { "neovim/nvim-lspconfig",   enabled = true },
        { "williamboman/mason.nvim", enabled = true },
    }
}

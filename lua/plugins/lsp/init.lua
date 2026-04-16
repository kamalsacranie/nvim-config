return {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
        vim.lsp.config("*", {
            root_markers = { ".git" },
            capabilities = {
                textDocument = {
                    semanticTokens = {
                        multilineTokenSupport = true,
                    }
                }
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if not client then
                    return
                end

                local map_keymap_list = require("nvim-mapper").map_keymap_list
                local mappings = require("plugins.lsp.mappings")
                map_keymap_list(mappings.lsp,
                    { buffer = ev.buf, fallback = false })

                if client.server_capabilities.documentHighlightProvider then
                    local doc_h_augroup = vim.api.nvim_create_augroup(
                        "DocumentHighlight",
                        { clear = true })
                    vim.api.nvim_create_autocmd("CursorHold", {
                        group = doc_h_augroup,
                        callback = vim.lsp.buf.document_highlight,
                        buffer = ev.buf,
                    })
                    vim.api.nvim_create_autocmd("CursorHoldI", {
                        group = doc_h_augroup,
                        callback = vim.lsp.buf.document_highlight,
                        buffer = ev.buf,
                    })
                    vim.api.nvim_create_autocmd("CursorMoved", {
                        group = doc_h_augroup,
                        callback = vim.lsp.buf.clear_references,
                        buffer = ev.buf,
                    })
                end
            end
        })

        vim.lsp.enable({ "lua_ls", "kotlin_lsp", "bashls", "ty" })
    end,
    dependencies = {
        { "neovim/nvim-lspconfig" },
        {
            "folke/neodev.nvim",
            config = function()
                require("neodev").setup()
            end
        },
        { "creativenull/efmls-configs-nvim" },
        { "nvim-telescope/telescope.nvim" },
        { "b0o/schemastore.nvim" }
    }
}

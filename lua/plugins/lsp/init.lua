return {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-lspconfig").setup_handlers(
            {
                function(server_name)
                    local server_cfg_exists, server_cfg = load_package("plugins.lsp.server_configs." .. server_name)
                    local lsp_server = require("lspconfig")[server_name]
                    lsp_server.setup(server_cfg or {})
                end
            }
        )
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(env)
                local bufnr = env.buf
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
                vim.keymap.set(
                    "n",
                    "K",
                    require('user.mappings.lsp_map').hover_callback, opts
                )
                vim.keymap.set(
                    "n",
                    "<leader>lca",
                    vim.lsp.buf.code_action,
                    opts
                )
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
                vim.keymap.set("n", "gh", vim.diagnostic.open_float)


                local client = vim.lsp.get_client_by_id(env.data.client_id)
                -- use this for some more interesting stuff
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

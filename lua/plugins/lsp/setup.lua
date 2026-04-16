local map_keymap_list = require("nvim-mapper").map_keymap_list
local mappings = require("plugins.lsp.mappings")

local on_attach_aucmd_callback = function(env)
    local bufnr = env.buf

    -- Keymaps
    map_keymap_list(mappings.lsp, { buffer = bufnr, fallback = false })

    -- Capability specific setups
    -- look into how we might define a callback. perhaps in the same file as our settings,
    -- we could have keys for the capabilities with callbacks
    local client = vim.lsp.get_client_by_id(env.data.client_id)
    if not client then
        return
    end

    if client.server_capabilities.documentRangeFormattingProvider then
        map_keymap_list(mappings.ranged_formatting, { buffer = bufnr })
    end
    if client.server_capabilities.documentHighlightProvider then
        local doc_h_augroup = vim.api.nvim_create_augroup("DocumentHighlight",
            { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            group = doc_h_augroup,
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("CursorHoldI", {
            group = doc_h_augroup,
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = doc_h_augroup,
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
        })
    end
    if client.server_capabilities.codeLensProvider then
        local codelens = vim.api.nvim_create_augroup(
            "LSPCodeLens",
            { clear = true }
        )
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" },
            {
                group = codelens,
                callback = function()
                    vim.lsp.inlay_hint.enable(true)
                    vim.lsp.codelens.refresh { bufnr = 0 }
                end,
                buffer = bufnr,
            })
    end
    if client.server_capabilities.completionProvider then
        vim.bo[bufnr].complete = ""
    end
    --[[ if client.server_capabilities.definitionProvider then
        vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end ]]
end

return function()
    -- masonlsp.setup({ PATH = "append" })
    -- masonlsp.setup_handlers({ function(server_name)
    --     -- change this to be a pcall and only pass if the module is not
    --     -- found. This is because the pcall can fail if something in the
    --     -- returned table fails too.
    --     local server_cfg = load_package("plugins.lsp.server_configs." ..
    --         server_name)
    --     local lspconfig = load_package("lspconfig")
    --     if not lspconfig then
    --         return
    --     end
    --     local lsp_server = lspconfig[server_name]
    --     lsp_server.setup(vim.tbl_deep_extend("force",
    --         lsp_server.document_config.default_config,
    --         server_cfg or {}))
    -- end,
    -- })
    -- vim.api.nvim_create_autocmd("LspAttach", {
    --     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    --     callback = on_attach_aucmd_callback
    -- })
    -- require("lspconfig").sourcekit.setup {
    --     filetypes = { "swift" },
    -- }
    -- require("lspconfig").ocamllsp.setup {
    --     filetypes = { "ocaml" },
    --     settings = {
    --         ocaml = { codelens = { enable = true } },
    --     }
    -- }
end

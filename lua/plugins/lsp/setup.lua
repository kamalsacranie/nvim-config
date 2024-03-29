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
    if client.server_capabilities.completionProvider then
        vim.bo[bufnr].complete = ""
    end
    --[[ if client.server_capabilities.definitionProvider then
        vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end ]]
end

return function()
    local mason = load_package("mason")
    local masonlsp = load_package("mason-lspconfig")
    if not masonlsp or not mason then
        return
    end
    mason.setup()
    masonlsp.setup()
    masonlsp.setup_handlers({
        function(server_name)
            local server_cfg = load_package("plugins.lsp.server_configs." ..
                server_name)
            local lspconfig = load_package("lspconfig")
            if not lspconfig then
                return
            end
            local lsp_server = lspconfig[server_name]
            lsp_server.setup(server_cfg or {})
        end,
    })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = on_attach_aucmd_callback
    })
end

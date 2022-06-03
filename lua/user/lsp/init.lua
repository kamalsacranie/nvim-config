-- Nice diagnostic icons
local icons = require("utils.icons")
local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
}
for _, sign in ipairs(signs) do
    vim.fn.sign_define(
        sign.name,
        { texthl = sign.name, text = sign.text, numhl = "" }
    )
end

vim.diagnostic.config({
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
        active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- Chanign the style of our popup windows via handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded" }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded" }
)

local servers = require("user.lsp.lsp_install")

---@diagnostic disable-next-line: unused-local
local is_loaded, lspconfig = LOAD_PACKAGE("lspconfig")
if not is_loaded then
    return
end

local pre_init = require("user.lsp.pre_init")
local server_settings = require("user.lsp.server_settings")

for _, server in pairs(servers) do
    local opts = {
        on_attach = pre_init.on_attach,
        capabilities = pre_init.capabilities,
    }
    if has_key(server_settings, server) then
        opts = vim.tbl_deep_extend(
            "force",
            server_settings[server],
            opts
        )
    end
    lspconfig[server].setup(opts)
end

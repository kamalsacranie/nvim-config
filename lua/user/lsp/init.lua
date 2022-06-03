local is_loaded, lspconfig = load_package("lspconfig")
if not is_loaded then
    return
end

require("user.lsp.visual") -- sets theme for diagnostics

local servers = require("user.lsp.lsp_install") -- sets up lspinstall and returns server names
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

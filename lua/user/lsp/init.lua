local is_loaded, lspconfig = load_package("lspconfig")
if not is_loaded then
	return
end

-- loading ansilliary things
local null_ls_did_load, _ = require("null-ls")
if null_ls_did_load then
	require("user.lsp.null_ls")
end

require("user.lsp.visual") -- sets theme for diagnostics

-- Finish with the big setup!!
local servers = require("user.lsp.lsp_install") -- sets up lspinstall and returns server names
local pre_init = require("user.lsp.pre_init")
local server_settings = require("user.lsp.server_settings")

for _, server in pairs(servers) do
	local opts = {
		on_attach = pre_init.on_attach,
		capabilities = pre_init.capabilities,
	}
	opts = vim.tbl_deep_extend("keep", server_settings[server] or {}, opts)
	lspconfig[server].setup(opts)
end

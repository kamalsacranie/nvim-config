local is_loaded, lspconfig = load_package("lspconfig")
if not is_loaded then
	return
end

-- loading ansilliary things
local null_ls_did_load, _ = load_package("null-ls")
if null_ls_did_load then
	require("user.lsp.null_ls")
end

require("user.lsp.visual") -- sets theme for diagnostics

-- Finish with the big setup!!
local servers = require("user.lsp.lsp_install") -- sets up lspinstall and returns server names
local pre_init = require("user.lsp.pre_init")
-- local server_settings = require("user.lsp.server_settings")

-- Loops through our list of servers and then sets up the options by
-- dynamically calling our setting option files
for _, server in pairs(servers) do
	local opts = {
		on_attach = pre_init.on_attach,
		capabilities = pre_init.capabilities,
	}
	local is_server, settings =
		pcall(require, "user.lsp.server_settings." .. server)
	if is_server then
		opts = vim.tbl_deep_extend("keep", settings or {}, opts)
	end
	lspconfig[server].setup(opts)
end

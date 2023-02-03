local is_loaded, lsp_config = load_package("lspconfig")
if not is_loaded then
	return
end

local pre_init = require("user.lsp.on_attach")
local base_opts = {
	on_attach = pre_init.on_attach,
	capabilities = pre_init.capabilities,
}
require("user.lsp.visual") -- sets theme for diagnostics

-- loading ansilliary things
local null_ls_did_load, _ = load_package("null-ls")
if null_ls_did_load then
	require("user.lsp.null_ls")
end

local mason_lsp_did_load, mason_lsp = load_package("mason-lspconfig")
if not mason_lsp_did_load then
	return
end

--- Getting a list of installed servers
local servers = mason_lsp.get_installed_servers()
local lsp_handlers = {
	function(server) -- default handler for servers without
		lsp_config[server].setup({ base_opts })
	end,
}

-- We set up all the mason stuff in the packer file
-- Loops through our list of servers and then sets up the options by
-- dynamically calling our setting option files
for _, server in pairs(servers) do
	local is_server, settings =
		pcall(require, "user.lsp.server_settings." .. server)
	local server_opts = {}
	if is_server then
		server_opts = vim.tbl_deep_extend("force", base_opts, settings or {})
	end
	lsp_handlers[server] = function()
		lsp_config[server].setup(server_opts)
	end
end

mason_lsp.setup_handlers(lsp_handlers)

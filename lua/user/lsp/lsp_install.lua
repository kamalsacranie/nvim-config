local is_loaded, lsp_installer = load_package("nvim-lsp-installer")
if not is_loaded then
	return
end

-- Only some of the installed servers are returned when we run
-- get_installed_servers on init

local function get_server_names()
	local servers = {}
	for i, server in ipairs(lsp_installer.get_installed_servers()) do
		servers[i] = server.name
	end
	return servers
end

local cfg = {
	-- see defaults at :h nvim-lsp-installer-default-settings
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
}

lsp_installer.setup(cfg)

return get_server_names()

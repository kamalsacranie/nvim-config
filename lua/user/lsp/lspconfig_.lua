-- nvim-lsp-installer setup allows us to install servers locally not globally
-- When the server is ready we attach our regular on_attatch function and then
-- any options we edit the table
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		-- requireing cmp into our capabilities
		capabilities = require("cmp_nvim_lsp").update_capabilities(
			vim.lsp.protocol.make_client_capabilities()
		),
	}

	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					-- Tell the language server about the vim global variable
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files. The first
					-- arg accepts a string to match for the runtime file and
					-- the second is whether to return all files or jsut the
					-- first one
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		}
	end
	server:setup(opts)
	-- vim.cmd([[ do User LspAttachBuffers ]])
end)

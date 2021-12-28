if not vim.g.lspconfig then
	return
end

local on_attach = require("utils.lspattach").on_attach
require("lspsaga").setup()

-- Disables virtual text globally so we just use gh to show the error. Other
-- config can be seen in the help menu
vim.diagnostic.config({
	virtual_text = false,
})

-- Make the borders of the hover and signature round. vim.lsp.with takes the
-- handler and then an override config. In this case the config options are the
-- same as nvim_open_win() config
-- This was done becuase people stopped deciding to support LSPSaga but now its
-- back in development
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{ border = "rounded" }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signatureHelp,
	{ border = "rounded" }
)

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

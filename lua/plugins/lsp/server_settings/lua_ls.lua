return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- Adding all plugins to our library
				library = vim.api.nvim_get_runtime_file("lua", true),
				checkThirdParty = false,
			},
			format = {
				enable = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
	-- custom on attatch function that disables formatting
	on_attach = function(client, bufnr)
		local on_attach = require("plugins.lsp.on_attach")
		-- The client has resolved capabilities and we set this to false
		client.server_capabilities.document_formatting = true -- via null_ls [perhaps move this into the null_ls file??]
		client.server_capabilities.document_highlight = true -- activates document highlight
		on_attach.on_attach(client, bufnr)
	end,
}

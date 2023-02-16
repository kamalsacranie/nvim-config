return {
	on_attach = function(client, bufnr)
		local on_attach = require("user.lsp.on_attach")
		-- disabling formatting
		client.server_capabilities.documentFormattingProvider = false
		on_attach.on_attach(client, bufnr)
	end,
}

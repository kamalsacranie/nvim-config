local helpers = require("utils.helpers")

return {
	on_attach = function(client, bufnr)
		if
			helpers.root_directory_from_pattern(
				vim.fn.getcwd(bufnr),
				"deno.jsonc"
			)
		then
			client.stop()
		end
		local on_attach = require("plugins.lsp.on_attach")
		-- disabling formatting
		client.server_capabilities.documentFormattingProvider = false
		on_attach.on_attach(client, bufnr)
	end,
}

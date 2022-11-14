return {
	commands = {
		PyrightOrganizeImports = {
			function()
				vim.lsp.buf.execute_command({
					command = "pyright.organizeimports",
					arguments = { vim.uri_from_bufnr(0) },
				})
			end,
			description = "Organize Imports",
		},
	},
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "on",
			},
		},
	},
	on_attach = function(client, bufnr)
		local pre_init = require("user.lsp.pre_init")
		client.server_capabilities.document_highlight = true
		vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
		pre_init.on_attach(client, bufnr)
	end,
}

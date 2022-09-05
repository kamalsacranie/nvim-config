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
}

return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
                -- Adding all plugins to our library
				library = vim.api.nvim_get_runtime_file("", true),
				-- [vim.fn.stdpath("config") .. "/lua"] = true,
				-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
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
		local pre_init = require("user.lsp.pre_init")
		-- The client has resolved capabilities and we set this to false
		client.resolved_capabilities.document_formatting = false
		pre_init.on_attach(client, bufnr)
	end,
}

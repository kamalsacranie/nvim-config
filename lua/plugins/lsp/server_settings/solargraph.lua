vim.env.SOLARGRAPH_CACHE = vim.fn.expand("$XDG_CACHE_HOME") .. "/solargraph"
return {
	on_attach = function(client, bufnr)
		local pre_init = require("plugins.lsp.pre_init")
        -- Setting an environemnt variable for the cache directory before starting the LSP
		vim.env.SOLARGRAPH_CACHE = vim.fn.expand("$XDG_CACHE_HOME")
			.. "/solargraph"
		-- The client has resolved capabilities and we set this to false
		pre_init.on_attach(client, bufnr)
	end,
}

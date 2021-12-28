local null_ls = require("null-ls")
local builtins = null_ls.builtins
local sources = {
	builtins.formatting.stylua.with({
		extra_args = { "--column-width", "80" },
	}),
	builtins.formatting.prettier,
	-- Markdown linting with MD025 disbaled so we can have mutiple levle one
	-- headings
	builtins.diagnostics.markdownlint.with({
		extra_args = { "--disable", "MD025" },
	}),
	builtins.formatting.black.with({ extra_args = { "-l79" } }),
	builtins.diagnostics.flake8,
}

null_ls.setup({
	sources = sources,
	on_attach = require("utils.lspattach").on_attach,
})

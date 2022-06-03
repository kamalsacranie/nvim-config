--[[ local null_ls = require("null-ls")
local builtins = null_ls.builtins
local sources = {
	-- builtins.formatting.stylua.with({
	-- 	extra_args = { "--column-width", "80" },
	-- }),
	builtins.formatting.prettier.with({
		disabled_filetypes = { "markdown", "json" },
	}),
	-- Markdown linting with MD025 disbaled so we can have mutiple levle one
	-- headings
	builtins.formatting.markdownlint,
	builtins.diagnostics.markdownlint.with({
		extra_args = { "--disable", "MD025" },
	}),
	-- Python formatting
	builtins.formatting.black.with({ extra_args = { "-l79" } }),
	builtins.diagnostics.flake8,
	-- Latex formatting
	builtins.diagnostics.chktex,
	-- Shell formatting
	builtins.formatting.shfmt,
}

null_ls.setup({
	sources = sources,
	on_attach = require("user.lsp.pre_init").on_attach,
}) --]]

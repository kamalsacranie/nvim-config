local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	formatting.stylua.with({
		extra_args = { "--column-width", "80" },
	}),
	-- formatting.prettier.with({
	--     disabled_filetypes = { "markdown", "json" },
	-- }),
	-- Markdown linting with MD025 disbaled so we can have mutiple levle one
	-- headings
	formatting.markdownlint,
	diagnostics.markdownlint.with({
		extra_args = { "--disable", "MD025" },
	}),
	-- Python formatting
	formatting.black.with({ extra_args = { "-l79" } }),
	diagnostics.flake8,
	-- Latex formatting
	diagnostics.chktex,
	-- Shell formatting
	formatting.shfmt,
}

null_ls.setup({
	sources = sources,
	on_attach = require("user.lsp.pre_init").on_attach_base,
})

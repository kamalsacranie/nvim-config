local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover

-- Perhaps we should do a filetype specific sourcing thing in our after/ directory??
local sources = {
	formatting.stylua.with({
		extra_args = { "--column-width", "80" },
	}),
	formatting.prettier.with({
		disabled_filetypes = {
			"markdown",
			"rmd",
			"md",
			"markdown.pandoc",
			"rmarkdown",
		},
	}),
	-- Markdown linting with MD025 disbaled so we can have mutiple levle one
	-- headings
	formatting.markdownlint.with({
		filetypes = { "markdown", "anki" },
	}),
	diagnostics.markdownlint.with({
		extra_args = { "--disable", "MD025" },
		filetypes = { "markdown", "anki" },
	}),
	-- Python formatting
	--[[ Black seems to not want a "command" option which means i must install
	black in every project instead of using the system black --]]
	formatting.black.with({
		extra_args = { "-l79" },
	}),
	diagnostics.flake8,
	-- Latex formatting
	diagnostics.chktex.with({
		filetypes = { "latex", "plaintex", "bib", "tex" },
	}),
	-- Shell formatting
	formatting.shfmt,
	code_actions.gitsigns, -- soooo useful
	hover.dictionary.with({
        filetypes = {"markdown", "anki", "rmarkdown", "text", "gitcommit"}
    }),
}

null_ls.setup({
	sources = sources,
	on_attach = require("user.lsp.pre_init").on_attach,
})

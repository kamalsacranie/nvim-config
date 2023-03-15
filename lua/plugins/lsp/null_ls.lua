local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover

-- Perhaps we should do a filetype specific sourcing thing in our after/ directory?? This is soooo coupled
-- We could have like, a nullls table which just specifies the builtin and maybe some options and then
-- dynamically populate the list
local sources = {
	formatting.stylua.with({
		extra_args = { "--column-width", "80" },
	}),
	formatting.prettier.with({
		disabled_filetypes = {
			"markdown",
			"rmd",
			"md",
			"rmarkdown",
		},
	}),
	-- Markdown linting with MD025 disbaled so we can have mutiple levle one
	-- headings
	-- formatting.markdownlint.with({
	-- 	filetypes = { "markdown", "anki" },
	-- 	cmd = { "markdownlink", "-f" },
	-- }),
	-- diagnostics.markdownlint.with({
	-- 	extra_args = { "--disable", "MD025" },
	-- 	filetypes = { "markdown", "anki" },
	-- }),
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
		filetypes = {
			"markdown",
			"anki",
			-- "rmd", -- slight problem here as there are times i will need doc hover and dicitonary hover. This means that I must find a way to implement a callback which decides which one to use. Most likley have to use treesitter...
			"text",
			"gitcommit",
		},
	}), -- shows definition for word,
}

null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)
		local pre_init = require("plugins.lsp.on_attach")
		-- Quick patch so that i can still use gqq in markdown. Should be done the same way as in regular lsp
		if get_filetype() == "anki" or get_filetype() == "md" then
			vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
		end
		pre_init.on_attach(client, bufnr)
	end,
})

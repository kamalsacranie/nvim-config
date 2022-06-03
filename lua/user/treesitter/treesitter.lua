require("nvim-treesitter.configs").setup({
	highlight = { enable = true, additional_vim_regex_highlighting = true },
	indent = { enable = true, disable = { "python" } },
	ensure_installed = {
		"tsx",
		"toml",
		"markdown",
		"json",
		"yaml",
		"html",
		"css",
		"python",
		"lua",
		"javascript",
		"latex",
	},
})

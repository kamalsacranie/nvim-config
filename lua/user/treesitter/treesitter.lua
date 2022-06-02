require("nvim-treesitter.configs").setup({
	highlight = { enable = true, disable = {} },
	indent = { enable = true, disable = { "python" } },
	ensure_installed = {
		"tsx",
		"toml",
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

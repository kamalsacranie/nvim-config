local is_loaded, _ = load_package("nvim-treesitter.configs")
if not is_loaded then
	return
end

require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
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

require("user.treesitter.settings")

-- Allowing our treesitter fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

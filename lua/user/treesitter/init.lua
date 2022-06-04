local is_loaded, _ = load_package("nvim-treesitter.configs")
if not is_loaded then
	return
end

require("user.treesitter.settings")
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

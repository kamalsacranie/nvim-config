local is_loaded, _ = LOAD_PACKAGE("nvim-treesitter.configs")
if not is_loaded then
	return
end

require("user.treesitter.settings")

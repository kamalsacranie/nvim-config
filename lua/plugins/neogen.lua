-- Docstrings
local function setup()
	local loaded, neogen = load_package("neogen")
	if not loaded then
		return
	end

	local defaults = { enable = true, snippet_engine = "luasnip" }

	-- ensures that the filetype loads before we extend our config
	vim.schedule(function()
		neogen.setup(extend_config(defaults, "neogen_config_extend"))
	end)
end

return {
	"danymat/neogen",
	config = setup,
	dependencies = "nvim-treesitter/nvim-treesitter",
}

-- Docstrings
local function setup()
	local loaded, neogen = load_package("neogen")
	if not loaded then
		return
	end

	local defaults = { enable = true }

	local extended_config = extend_config(defaults, "neogen_config_extend")
	neogen.setup(extended_config)
end

return {
	"danymat/neogen",
	config = setup,
	dependencies = "nvim-treesitter/nvim-treesitter",
}

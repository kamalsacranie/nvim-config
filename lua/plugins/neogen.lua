-- Docstrings
local function setup()
	local loaded, neogen = load_package("neogen")
	if not loaded then
		return
	end

	local defaults = { enable = true }

	neogen.setup(extend_config(defaults, "neogen_config_extend"))
end

return {
	"danymat/neogen",
	config = setup,
	dependencies = "nvim-treesitter/nvim-treesitter",
}

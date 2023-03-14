local setup = function()
	local icons = require("utils.icons")
	-- Setting up exernal mappings
	require("user.mappings.filetree_map")
	local filet_did_load, nvim_tree = load_package("nvim-tree")
	if not filet_did_load then
		return
	end

	nvim_tree.setup()
end

-- File explorer
return {
	"kyazdani42/nvim-tree.lua",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	keys = "X",
	tag = "nightly",
	config = setup,
}

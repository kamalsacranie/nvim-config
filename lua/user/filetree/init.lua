local filet_did_load, nvim_tree = load_package("nvim-tree")
if not filet_did_load then
	return
end

-- Setting up mappings
require("user.mappings.filetree_map")
nvim_tree.setup()

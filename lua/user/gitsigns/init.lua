local gs_did_load, gitsigns = load_package("gitsigns")
if not gs_did_load then
	return
end

gitsigns.setup()
require("user.mappings.gitsigns_map")

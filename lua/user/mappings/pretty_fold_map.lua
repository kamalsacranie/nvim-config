local pfp_did_load, pfp = load_package("pretty-fold.preview")
if not pfp_did_load then
	return
end

local M = {}

M.pfp_callback = function()
	if vim.fn.foldclosed(".") ~= -1 then
		return pfp.mapping.show_close_preview_open_fold()
	end
end

kmap(
	"n",
	"K",
	"<CMD>lua require('user.mappings.pretty_fold_map').pfp_callback()<CR>"
)

return M

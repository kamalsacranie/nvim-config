local pfp_did_load, pfp = load_package("pretty-fold.preview")
if not pfp_did_load then
	return
end
-- Using keymap-amend to allow the preservation of the original mapping
local amend_did_load, kmap_amend = load_package("keymap-amend")
if not amend_did_load then
	return
end

kmap_amend("n", "K", function(original)
	if vim.fn.foldclosed(".") ~= -1 then
		pfp.mapping.show_close_preview_open_fold()
	end
	original()
end)

local setup = function()
	local fp_did_load, fold_preview = load_package("fold-preview")
	if not fp_did_load then
		return
	end
	fold_preview.setup({
		border = "shadow",
	})
end

return {
	"anuvyklack/fold-preview.nvim",
	requires = "anuvyklack/keymap-amend.nvim",
	config = setup,
}

local function setup()
	local loaded, gs = load_package("gitsigns")
	if not loaded then
		return
	end
	gs.setup({
		on_attach = function(bufnr)
			require("user.mappings.gitsigns_map").gitsigns_mappings(bufnr)
		end,
	})
end

return {
	"lewis6991/gitsigns.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	-- Only config required
	config = setup,
}

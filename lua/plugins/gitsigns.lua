return {
	"lewis6991/gitsigns.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	-- Only config required
	config = function()
		require("user.gitsigns")
	end,
}

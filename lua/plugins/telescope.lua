return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	config = function()
		require("user.telescope")
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
}

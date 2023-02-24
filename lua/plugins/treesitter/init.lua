return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("plugins.treesitter.setup")
	end,
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/playground",
		"JoosepAlviste/nvim-ts-context-commentstring",
		"HiPhish/nvim-ts-rainbow2",
	},
}

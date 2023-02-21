return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			autotag = {
				enable = true,
			},
		})
	end,
	dependencies = {
		"windwp/nvim-ts-autotag",
		"p00f/nvim-ts-rainbow",
		"nvim-treesitter/playground",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
}

return {
	"hrsh7th/nvim-cmp",
	config = function()
		require("user.cmp")
	end,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"jc-doyle/cmp-pandoc-references",
		"saadparwaiz1/cmp_luasnip",
		"jmbuhr/otter.nvim",
		-- temp completion sourse until we find something better
		{
			"jackieaskins/cmp-emmet",
			build = "npm run release",
		},
	},
}

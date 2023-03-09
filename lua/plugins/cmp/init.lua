return {
	"hrsh7th/nvim-cmp",
	config = function()
		require("plugins.cmp.setup")
	end,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"jc-doyle/cmp-pandoc-references",
		"saadparwaiz1/cmp_luasnip",
		-- temp completion sourse until we find something better for html emmet
		{
			"jackieaskins/cmp-emmet",
			build = "npm run release",
		},
	},
}

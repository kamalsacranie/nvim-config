return {
	"neovim/nvim-lspconfig",
	config = function()
		require("plugins.lsp.setup")
	end,
	dependencies = {
		"b0o/schemastore.nvim",
		{
			"folke/neodev.nvim",
			config = function()
				require("neodev").setup({})
			end,
		},
	},
}

return {
	"neovim/nvim-lspconfig",
	config = function()
		require("user.lsp")
	end,
	requires = {
		"ray-x/lsp_signature.nvim",
		"b0o/schemastore.nvim",
	},
}

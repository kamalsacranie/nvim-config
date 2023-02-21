-- Tabout of surrounding brackets

return {
	"abecodes/tabout.nvim",
	config = function()
		require("user.tabout")
	end,
	dependencies = "nvim-treesitter",
}

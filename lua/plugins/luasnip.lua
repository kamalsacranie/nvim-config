return {
	"L3MON4D3/LuaSnip",
	version = "v<CurrentMajor>.*",
	config = function()
		require("user.luasnip")
	end,
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
}

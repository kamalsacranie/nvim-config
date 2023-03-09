return {
	"L3MON4D3/LuaSnip",
	version = "v<CurrentMajor>.*",
	enabled = true,
	config = function()
		require("plugins.luasnip.setup")
	end,
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
}

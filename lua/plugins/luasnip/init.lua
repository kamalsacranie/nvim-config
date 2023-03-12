return {
	"L3MON4D3/LuaSnip",
	version = "1.2.1.*",
	enabled = true,
	build = "make install_jsregexp",
	config = function()
		require("plugins.luasnip.setup")
	end,
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
}

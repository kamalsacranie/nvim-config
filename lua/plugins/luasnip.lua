return {
	"L3MON4D3/LuaSnip",
	version = "v<CurrentMajor>.*",
	config = function()
		local luasnip_did_load, ls = load_package("luasnip")
		if not luasnip_did_load then
			return
		end
		-- Set path to load snippets from
		require("luasnip.loaders.from_lua").load({
			paths = {
				"./after/ftsnippets/lua",
			},
		})
		-- temp to load friendly snippets
		require("luasnip/loaders/from_vscode").load({
			paths = {
				"~/.local/share/nvim/lazy/friendly-snippets",
			},
			override_priority = 999, -- setting the priority 1 less than default luasnip priority
		})

		-- temp forcing visual mode to allow tab visual snippet
		bkmap(
			"v",
			"<Tab>",
			[[:'<,'>lua require('luasnip.util.util').store_selection()<CR>gvs]]
		)

		local defaults = {
			history = true,
			update_events = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		}

		require("user.mappings.luasnip_map")
		ls.config.setup(EXTEND_CONFIG(defaults, "luasnip_config_extend"))
	end,
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
}

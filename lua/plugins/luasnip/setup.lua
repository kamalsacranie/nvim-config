local luasnip_did_load, ls = load_package("luasnip")
if not luasnip_did_load then
	return
end
-- Set path to load snippets from. Very important to lazy load if you want a reasonable stratup
require("luasnip.loaders.from_lua").lazy_load({
	paths = {
		"./after/ftsnippets/lua",
	},
})

-- temp to load friendly snippets
require("luasnip/loaders/from_vscode").lazy_load({
	paths = {
		"~/.local/share/nvim/lazy/friendly-snippets",
	},
	override_priority = 999, -- setting the priority 1 less than default luasnip priority
})

local defaults = {
	history = true,
	update_events = "TextChanged,TextChangedI",
	enable_autosnippets = true,
}

require("user.mappings.luasnip_map")
ls.config.setup(EXTEND_CONFIG(defaults, "luasnip_config_extend"))

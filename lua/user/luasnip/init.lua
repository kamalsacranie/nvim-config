local types = require("luasnip.util.types")
local luasnip_did_load, ls = load_package("luasnip")
if not luasnip_did_load then
	return
end
-- Set path to load snippets from
require("luasnip.loaders.from_lua").load({ paths = "./after/ftsnippets/lua" })

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

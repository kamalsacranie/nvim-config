local luasnip_did_load, ls = load_package("luasnip")
if not luasnip_did_load then
	return
end
-- Set path to load snippets from
require("luasnip.loaders.from_lua").load({ paths = "./after/ftsnippets/lua" })

vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)

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

ls.config.setup(EXTEND_CONFIG(defaults, "luasnip_config_extend"))

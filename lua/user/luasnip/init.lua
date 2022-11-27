local luasnip_did_load, ls = load_package("luasnip")
if not luasnip_did_load then
	return
end
-- Set path to load snippets from
require("luasnip.loaders.from_lua").load({ paths = "./after/ftsnippets/lua" })

vim.keymap.set({ "i", "s" }, "<C-f>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)
vim.keymap.set({ "i", "s" }, "<C-b>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)

require("luasnip.config").setup({
	history = true,
	update_events = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

local luasnip_did_load, ls = load_package("luasnip")
if not luasnip_did_load then
	return
end
local tabout_did_load, tabout = load_package("tabout")

-- allows us to either jump forward in snippet or tabout
vim.keymap.set({ "i", "s" }, "<C-f>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	elseif tabout_did_load then
		tabout.tabout()
	end
end)
vim.keymap.set({ "i", "s" }, "<C-b>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	elseif tabout_did_load then
		tabout.taboutBack()
	end
end)

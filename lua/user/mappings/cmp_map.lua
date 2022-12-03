local cmp_did_load, cmp = load_package("cmp")
if not cmp_did_load then
	return
end

return {
	["<C-d>"] = function(fallback)
		if cmp.visible() then
			cmp.scroll_docs(4)
		else
			fallback()
		end
	end,
	["<C-u>"] = function(fallback)
		if cmp.visible() then
			cmp.scroll_docs(-4)
		else
			fallback()
		end
	end,
	["<C-c>"] = function(fallback)
		if cmp.visible() then
			cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			})
		else
			fallback()
		end
	end,
	-- Mapping control n to next item
	["<C-n>"] = function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		else
			fallback()
		end
	end,
	-- Mapping control p to previous item
	["<C-p>"] = function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		else
			fallback()
		end
	end,
	-- Mapping tab to completion
	-- TODO: add exlicit modes for when this applies
	["<Tab>"] = function(fallbalck)
		if cmp.visible() then
			cmp.confirm({ select = true })
		else
			fallbalck()
		end
	end,
}

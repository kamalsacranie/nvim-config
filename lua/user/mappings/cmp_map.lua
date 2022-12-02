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
	["<Tab>"] = function(fallbalck)
		local neogen_did_load, neogen = load_package("neogen")
		if cmp.visible() then
			cmp.confirm({ select = true })
		elseif neogen_did_load and neogen.jumpable() then
			-- I should really map this to the snipppet jump command <c-f> but I just cba to set it all up now
			neogen.jump_next()
			-- The fall back allows us to use the regular behavoiur if the
			-- condition is not met
		else
			fallbalck()
		end
	end,
	["<S-Tab>"] = function(fallbalck)
		local neogen_did_load, neogen = load_package("neogen")
		if neogen_did_load and neogen.jumpable(true) then
			neogen.jump_prev()
		else
			fallbalck()
		end
	end,
}

local wrap = function()
	return f(function(_, snip)
		-- allows us to return multiple lines
		local response, env = {}, snip.env
		for _, v in ipairs(env.LS_SELECT_RAW) do
			table.insert(response, v)
		end
		return response or {}
	end)
end

return {
	s({ trig = "img", name = "image" }, {
		t("!["),
		i(1),
		t("]"),
		t("("),
		wrap(),
		t(")"),
		i(0),
	}),
}

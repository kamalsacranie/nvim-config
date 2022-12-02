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
	s({ trig = "ref", name = "reference" }, {
		t([[\@ref(]]),
		wrap(),
		i(1),
		t(")"),
		i(0),
	}),
	s(
		{ trig = "appendix", name = "Appendix" },
		t("# (APPENDIX) Appendices {-}")
	),
	s(
		{ trig = "part", name = "Part" },
		{ t("# (PART) "), wrap(), i(1), t(" {-}"), i(0) }
	),
}

local wrap = function()
	return f(function(_, snip)
		-- allows us to return multiple lines
		local response, env = {}, snip.env
		P(env)
		if next(env.LS_SELECT_RAW) == nil then
			return {}
		end
		-- if env.LS_SELECT_RAW.
		for _, v in ipairs(env.LS_SELECT_RAW) do
			table.insert(response, v)
		end
		return response or {}
	end)
end

return {
	s({ trig = "c'", name = "inline code" }, {
		t("`"),
		wrap(),
		i(1),
		t("`"),
	}),
	s({ trig = "b'", name = "bold" }, { t("**"), wrap(), i(1), t("**") }),
	s(
		{ trig = "fn", name = "footnote", wordTrig = true },
		{ t("^["), wrap(), i(1), t("]") }
	),
	s({ trig = "i'", name = "italics" }, { t("*"), wrap(), i(1), t("*") }),
	s(
		{ trig = "bi'", name = "bitalics" },
		{ t("***"), wrap(), i(1), t("***") }
	),
	s({ trig = "d'", name = "math" }, { t("$"), wrap(), i(1), t("$"), i(2) }),
	s("link", { t("["), i(1), t("]("), wrap(), i(2), t(")"), i(0) }),
}

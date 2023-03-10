local conds = require("luasnip.extras.conditions.expand")

return {
	s(
		{ trig = "impo?r?t?", name = "Import statement", regTrig = true },
		fmta( -- should use a functional snippet for * automatic adding as {}
			[[
                import <> from "<>"
                ]],
			{ i(2), i(1) }
		),
		{ condition = conds.line_begin }
	),
	s(
		{
			trig = "(.*)ts",
			name = "Template substitution",
			regTrig = true,
		},
		fmta(
			"<>${<>}",
			{ f(function(_, snip)
				return snip.captures[1]
			end), i(1) }
		),
		{
			condition = function()
				return is_child_of_node("template_string")
			end,
		}
	),
}

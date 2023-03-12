local conds = require("luasnip.extras.conditions.expand")
local tsh = require("utils.treesitter-helpers")

return
	{
		s({ trig = "clog" }, { t("console.log("), i(1), t(")") }),
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
			fmta("<>${<>}", {
				f(function(_, snip)
					return snip.captures[1]
				end),
				i(1),
			}),
			{
				condition = function()
					return tsh.is_child_of_node("template_string")
				end,
			}
		),
	}

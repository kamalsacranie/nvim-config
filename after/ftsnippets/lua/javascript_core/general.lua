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
}

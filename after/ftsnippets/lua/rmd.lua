return {
	s(
		"link",
		fmta([[[<>](<>)]], {
			i(1, "test"),
			i(2, "url"),
		})
	),
	s(
		{
			trig = "eqn",
			dscr = "Expands 'eq' into an equation environment",
			snippetType = "autosnippet",
		},
		fmta(
			[[
                \begin{equation*}
                  <>
                \end{equation*}
            ]],
			{ i(1) }
		),
		{ condition = conds.line_begin }
	),
}

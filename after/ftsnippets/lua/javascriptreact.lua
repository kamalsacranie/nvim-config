return {
	s(
		{ trig = "useState" },
		fmta(
			[[
            const [<1>, set<2>] = useState()
            ]],
			{
				i(1),
				d(2, function(args)
					return require("utils.snippit-utils").capitalise_first_letter(
						args[1][1]
					)
				end, { 1 }),
			}
		)
	),
}

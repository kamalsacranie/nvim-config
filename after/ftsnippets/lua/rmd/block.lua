local aub = function(params, nodes, opts)
	return s(
		vim.tbl_extend("force", params, { snippetType = "autosnippet" }),
		nodes,
		vim.tbl_extend("force", opts or {}, { condition = conds.line_begin })
	)
end

return {
	aub(
		{
			trig = "cbl",
			name = "code block",
			dscr = "Creates languageless code block",
		},
		-- should change this into fucntion node where we put eval=F for any no r code
		fmta(
			[[
                ```{<1><2>}
                <3>
                ```
            ]],
			{
				i(1, "language"),
				c(2, {
					f(function(args, _)
						if args[1][1] ~= "r" then
							return ", echo=T, eval=F"
						end
						return ""
					end, { 1 }),
					t({ "" }),
				}),
				i(3, "code"),
			},
			i(0)
		)
	),
	aub(
		{
			trig = "fig",
			name = "figure",
			dscr = "Adds knitr figure",
		},
		fmta(
			[[
                ```{r <>, echo=F, eval=T}
                #| fig.cap="<>",
                #| out.height="30%",
                #| fig.align="center",
                knitr::include_graphics(
                  "<>"
                )
                ```
            ]],
			{ i(1, "fig.cap"), rep(1), i(2, "path") },
			i(0)
		)
	),
	aub(
		{ trig = "exm", name = "example", dscr = "Adds an example block" },
		fmta(
			[[
            ::: {.example #<> name="<>"}
            <<br />>\hfill\break
            <>
            
            :::
        ]],
			{ i(1, "reference"), i(2, "name"), i(3, "example content") },
			i(0)
		)
	),
}

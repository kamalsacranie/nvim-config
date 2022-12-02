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
		fmta(
			[[
                ```{<1>}
                <2>
                ```
            ]],
			{ i(1, "language"), i(2, "code") },
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
                ```{r <>, echo=F, eval=T\}
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
}

-- Simplification for auto expand at begining
local aub = function(params, nodes, opts)
	return s(
		vim.tbl_extend(
			"force",
			params,
			{ snippetType = "autosnippet", condition = conds.line_begin }
		),
		nodes
	)
end

return {
	s(
		{
			trig = "callout",
			name = "Callout block",
			condition = conds.line_begin,
		},
		fmta(
			[[
            ::: {.callout-<>}
            ## <>
            
            <>
            :::
            ]],
			{
				c(1, { t("note"), t("important"), t("tip"), t("warning") }),
				i(2, "Callout title"),
				i(3),
			}
		)
	),
}, {
	s(
		{
			trig = "cbl",
			name = "Codeblocks",
			dscr = "Creates a codeblock",
			priority = 1001,
			condition = conds.line_begin,
		},
		fmta(
			[[
                ```<>
                <>
                ```
            ]],
			{ i(1), i(2) }
		),
		i(0)
	),
	aub(
		{
			trig = "eqn",
			name = "anonymous equation",
			dscr = "Expands 'eq' into an equation environment",
		},
		fmta(
			[[
		               \begin{equation*}
		                 <>
		               \end{equation*}
		           ]],
			{ i(1) }
		),
		i(0)
	),
	aub(
		{
			trig = "neqn",
			name = "numbered equation",
			dscr = "Expands 'eq' into an equation environment",
		},
		fmta(
			[[
		               \begin{equation}
		                 <> (\#eq:)
		               \end{equation}
		           ]],
			{ i(1) }
		),
		i(0)
	),
	aub(
		{
			trig = "ecb",
			name = "Executable codeblock",
			dscr = "creates codeblock environment",
		},
		fmta(
			[[
            ```{<>}
            <>
            ```
            ]],
			{ i(1), i(2) }
		),
		i(0)
	),
	aub(
		{
			trig = "lcb",
			name = "Executable codeblock",
			dscr = "creates codeblock environment",
		},
		fmta(
			[[
            ```<> {#lst-<> lst-cap="<>"<>}
            <>
            ```
            ]],
			{
				i(1),
				i(2),
				i(3),
				c(4, { t(""), t(' code-line-numbers="true"') }),
				i(5),
			}
		),
		i(0)
	),
	aub(
		{
			trig = "lecb",
			name = "Executable codeblock",
			dscr = "creates codeblock environment",
		},
		fmta(
			[[
            ```{<> #lst-<> lst-cap="<>"<>}
            <>
            ```
            ]],
			{
				i(1),
				i(2),
				i(3),
				c(4, { t(""), t(' code-line-numbers="true"') }),
				i(5),
			}
		),
		i(0)
	),
}

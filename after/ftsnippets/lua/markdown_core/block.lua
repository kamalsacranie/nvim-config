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

-- return {
-- 	s(
-- 		{
-- 			trig = "cbl",
-- 			name = "Codeblocks",
-- 			dscr = "Creates a codeblock",
-- 			priority = 1001,
-- 			-- snippetType = "autosnippet",
-- 			condition = conds.line_begin,
-- 		},
-- 		fmta(
-- 			[[
--                 ```{<>}
--                   <>
--                 ```
--             ]],
-- 			{ i(1), i(2) }
-- 		),
-- 		i(0)
-- 	),
-- 	aub(
-- 		{
-- 			trig = "eqn",
-- 			name = "anonymous equation",
-- 			dscr = "Expands 'eq' into an equation environment",
-- 		},
-- 		fmta(
-- 			[[
-- 		               \begin{equation*}
-- 		                 <>
-- 		               \end{equation*}
-- 		           ]],
-- 			{ i(1) }
-- 		),
-- 		i(0)
-- 	),
-- 	aub(
-- 		{
-- 			trig = "neqn",
-- 			name = "numbered equation",
-- 			dscr = "Expands 'eq' into an equation environment",
-- 		},
-- 		fmta(
-- 			[[
-- 		               \begin{equation}
-- 		                 <> (\#eq:)
-- 		               \end{equation}
-- 		           ]],
-- 			{ i(1) }
-- 		),
-- 		i(0)
-- 	),
-- 	aub(
-- 		{
-- 			trig = "cbl",
-- 			name = "codeblock",
-- 			dscr = "creates codeblock environment",
-- 		},
-- 		fmta(
-- 			[[
-- 		           ```{<>}
-- 		           <>
-- 		           ```
-- 		           ]],
-- 			{ i(1), i(2) }
-- 		),
-- 		i(0)
-- 	),
-- }

-- Simplification for auto expand at begining
return {
    s(
        {
            trig = "callout",
            name = "Callout block",
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
        ),
        { condition = conds.line_begin }
    ),
    s(
        {
            trig = "env",
            name = "Latex environemnt",
        },
        fmta(
            [[
            ::: {#<>-<>}
            ## <>

            <>
            :::
            ]],
            {
                c(1, {

                    t("thm"),
                    t("lem"),
                    t("cor"),
                    t("prp"),
                    t("cnj"),
                    t("def"),
                    t("exm"),
                    t("exr"),
                }),
                i(2),
                i(3, "Env title"),
                i(4),
            }
        ),
        { condition = conds.line_begin }
    ),
}, {
    s(
        {
            trig = "cbl",
            name = "Codeblocks",
            dscr = "Creates a codeblock",
            priority = 1001,
        },
        fmta(
            [[
                ```<>
                <>
                ```
            ]],
            { i(1), i(2) }
        ),
        i(0),
        {

            condition = conds.line_begin,
        }
    ),
    aub(
        {
            trig = "eqn",
            name = "anonymous equation",
            dscr = "Expands 'eqn' into an equation environment",
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
            trig = "optieq",
            name = "max/min subject to",
            dscr = "Maximum/minimum optimisation layout",
        },
        fmta(
            [[
                \begin{align}
                    \<>_{<>} \quad & <> \nonumber\\
                    \textrm{s.t.} \quad
                      & <>
                \end{align}
            ]],
            { c(1, { t("max"), t("min") }), i(2), i(3), i(4) }
        ),
        i(0)
    ),
    aub(
        {
            trig = "aeqn",
            name = "aligned anonymous equation",
            dscr = "Expands 'aeqn' into an equation environment",
        },
        fmta(
            [[
		               \begin{align*}
		                 <>
		               \end{align*}
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

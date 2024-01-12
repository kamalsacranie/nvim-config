return {
    s("link", { t("["), i(1), t("]("), visual(), i(2), t(")"), i(0) }),
    s({ trig = "appen?d?i?x?(%d*)", name = "Appendix heading", regTrig = true },
        {
            f(function(_, snip)
                local heading_level = tonumber(snip.captures[1]) or 1
                heading_level = math.min(heading_level, 6)
                return string.rep("#", heading_level) .. " "
            end),
            i(1),
            t(" {.appendix}"),
        }),
    s({ trig = "c'", name = "inline code" }, {
        t("`"),
        visual(),
        i(1),
        t("`"),
    }),
    s({ trig = "b'", name = "bold" }, { t("**"), visual(), i(1), t("**") }),
    s(
        { trig = "i'", name = "italics" },
        { t("*"), visual(), i(1), t("*") }
    ),
    s(
        { trig = "bi'", name = "bitalics" },
        { t("***"), visual(), i(1), t("***") }
    ),
    s(
        { trig = "d'", name = "math" },
        { t("$"), visual(), i(1), t("$"), i(2) }
    ),
    midword(
        { trig = [[(.*)fn]], name = "footnote", trigEngine = "pattern", show_condition = function() return false end },
        {
            t("^["),
            visual(),
            i(1),
            t("]"),
        }
    )
}

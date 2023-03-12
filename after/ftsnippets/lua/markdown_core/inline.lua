return {
	s({ trig = "c'", name = "inline code" }, {
		t("`"),
		t(some_global),
		lsg.visual(),
		i(1),
		t("`"),
	}),
	s({ trig = "b'", name = "bold" }, { t("**"), lsg.visual(), i(1), t("**") }),
	s(
		{ trig = "fn", name = "footnote", wordTrig = true },
		{ t("^["), lsg.visual(), i(1), t("]") }
	),
	s({ trig = "i'", name = "italics" }, { t("*"), lsg.visual(), i(1), t("*") }),
	s(
		{ trig = "bi'", name = "bitalics" },
		{ t("***"), lsg.visual(), i(1), t("***") }
	),
	s(
		{ trig = "d'", name = "math" },
		{ t("$"), lsg.visual(), i(1), t("$"), i(2) }
	),
	s("link", { t("["), i(1), t("]("), lsg.visual(), i(2), t(")"), i(0) }),
}

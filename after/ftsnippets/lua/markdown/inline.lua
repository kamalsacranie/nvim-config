return {
	s({ trig = "imgi", name = "image", snippetType = "autosnippet" }, {
		t("!["),
		i(1),
		t("]"),
		t("("),
		lsg.visual(),
		t(")"),
		i(0),
	}),
}

local jest_snippets = {
	s(
		{ trig = "desc", name = "Jest describe block" },
		-- we use two ang brackets to escape the one
		fmta(
			[[
                describe("<>", () =>> {
                  <>
                })
                ]],
			{ i(1), i(2) }
		),
		i(0)
	),
	s(
		{ trig = "([it][te]s?t?)", name = "Jest it test block", regTrig = true },
		fmta(
			[[
            <>("<>", () =>> {
              <>
            })
            ]],
			{
				f(function(_, snip)
					return "it"
				end),
				i(1),
				i(2),
			}
		),
		i(0)
	),
}

if
	vim.fn.expand("%"):match("%.test.[jt]s")
	or vim.fn.expand("%"):match("%.spec.[jt]s")
then
	return jest_snippets
end

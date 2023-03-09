-- in lua you use % to escape regex strings i think

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
	-- s(
	-- 	{ trig = "b(%d)", regTrig = true },
	-- 	f(function(args, snip)
	-- 		return "Captured Text: " .. snip.captures[1] .. "."
	-- 	end, {})
	-- ),
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

if string.gmatch(vim.fn.expand("%"), "%.(test|spec)%.(ts|js)") then
	return jest_snippets
end

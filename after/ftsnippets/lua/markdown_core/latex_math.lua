-- Not pretty but does the job. Will be so much better when we have treesitter grammar
-- Checks if we are in math syntax zone
local is_math = function()
	local synlist_raw = vim.api.nvim_command_output(
		[[echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')]]
	)
	local synlist = synlist_raw:gsub("%[", "{")
	synlist = synlist:gsub("%]", "}")
	synlist = "return " .. synlist
	synlist = load(synlist)()
	-- P(synlist)
	if not synlist then
		P(1)
		return false
	elseif synlist[#synlist] == "texMathText" then
		return false
	elseif synlist_raw:match("Math") then
		P(2)
		return true
	elseif synlist_raw:match("pandocLaTeXRegion") then
		P(3)
		return true
	else
		P(4)
		return false
	end
end

local wrap = function()
	return f(function(_, snip)
		-- allows us to return multiple lines
		local response, env = {}, snip.env
		for _, v in ipairs(env.LS_SELECT_RAW) do
			table.insert(response, v)
		end
		return response or {}
	end)
end

local ms = function(params, nodes, opts)
	return s(
		vim.tbl_extend(
			"force",
			params,
			{ wordTrig = true, snippetType = "autosnippet" }
		),
		nodes,
		vim.tbl_extend("force", opts or {}, { condition = is_math })
	)
end

return {
	ms({ trig = "substack" }, fmta([[\substack{<>}]], i(1)), i(0)),
	-- should improve these with regex. simple match pattern
	ms({ trig = "+" }, t(" + ")),
	ms({ trig = "-" }, t(" - ")),
	ms({ trig = "=" }, t(" = ")),
	ms({ trig = "**" }, t([[\times ]])),
	ms({ trig = "..." }, t([[\dots ]])),
	ms(
		{ trig = "frac" },
		{ t([[\frac]]), t("{"), i(1), t("}"), t("{"), i(2), t("}") },
		i(0)
	),
	ms({ trig = "text" }, { t([[\text]]), t("{"), wrap(), i(1), t("}") }, i(0)),
}

--
-- context "math()"
-- snippet matrix "Matrix"
-- \begin\{pmatrix\}
-- 	$1
-- \end\{pmatrix\}
-- endsnippet
--
-- context "math()"
-- snippet ... "dots" iA
-- \\dots
-- endsnippet
--
-- context "math()"
-- snippet frac "fraction" iA
-- \\dfrac\{${1}\}\{${2}\}${3}
-- endsnippet
--
-- context "math()"
-- snippet bar "bar" iA
-- \\overline\{${1}\}${2}
-- endsnippet
--
-- context "math()"
-- snippet hat "hat" iA
-- \\hat\{${1}\}${2}
-- endsnippet
--
-- context "math()"
-- snippet check "check" iA
-- \\check\{${1}\}${2}
-- endsnippet
--
-- context "math()"
-- snippet tilde "tilde" iA
-- \\widetilde\{${1}\}${2}
-- endsnippet
--
-- context "math()"
-- snippet sq "square" iA
-- ^\{2\}${1}
-- endsnippet
--
-- context "math()"
-- snippet = "equals" iA
--  =
-- endsnippet
--
-- context "math()"
-- snippet + "plus" iA
--  +
-- endsnippet
--
-- context "math()"
-- snippet - "minus" iA
--  -
-- endsnippet
--
-- context "math()"
-- snippet ** "times" iA
-- \\times
-- endsnippet
--
-- context "math()"
-- snippet rarr "rightarrow" iA
-- \\rightarrow
-- endsnippet
--
-- context "math()"
-- snippet Rarr "eqrightarrow" iA
-- \\Rightarrow
-- endsnippet
--
-- context "math()"
-- snippet ^ "superscript" iA
-- ^\{${1}\}${2}
-- endsnippet
--
-- context "math()"
-- snippet _ "subscript" iA
-- _\{${1}\}${2}
-- endsnippet
--
-- context "math()"
-- snippet sum "sum" iA
-- \sum_\{${1}\}^\{${2}\}${3}
-- endsnippet
--
-- context "math()"
-- snippet max "max" iA
-- \\underset\{${1:undertext}\}\max $0
-- endsnippet
--
-- context "math()"
-- snippet min "min" iA
-- \\underset\{${1:undertext}\}\min $0
-- endsnippet
--
-- context "math()"
-- snippet root "squareroot" iA
-- \\sqrt\{${1:underroot}\}$0
-- endsnippet
--
-- context "math()"
-- snippet left) "(brakcets" iA
-- \\left($1\\right)$2
-- endsnippet
--
-- context "math()"
-- snippet left] "[brakcets" iA
-- \\left[$1\\right]$2
-- endsnippet
--
-- context "math()"
-- snippet left} "{brakcets" iA
-- \\left\\{$1\\right\\}$2
-- endsnippet
--
-- snippet big) "big)" iA
-- \\big($1\\big)$2
-- endsnippet
--
-- context "math()"
-- snippet big] "big]" iA
-- \\big[$1\\big]$2
-- endsnippet
--
-- context "math()"
-- snippet big} "big}" iA
-- \\big\\{$1\\big\\}$2
-- endsnippet
--
-- context "math()"
-- snippet text "inmathtext" iA
-- \text\{ ${1:${VISUAL}} \}$2
-- endsnippet
--
-- context "math()"
-- snippet underbrace "undersetbrace" iA
-- \\underbrace\{$1\}_\{$2\}
-- endsnippet
--
-- context "math()"
-- snippet overbrace "oversetbrace" iA
-- \\overbrace\{$1\}^\{$2\}
-- endsnippet
--
-- context "math()"
-- snippet bold "boldface" i
-- \\mathbf{$1}
-- endsnippet
--
-- context "math()"
-- snippet geq "Greater than or equal to" iA
--  \\geq
-- endsnippet
--
-- context "math()"
-- snippet leq "Less than or equal to" iA
--  \\leq
-- endsnippet
--
-- context "math()"
-- snippet > "Greater than" iA
--  >
-- endsnippet
--
-- context "math()"
-- snippet < "Greater than" iA
--  <
-- endsnippet
--
-- context "math()"
-- snippet expected "Expected value operator" iA
-- \\mathbb E[$1]$2
-- endsnippet
--
-- context "math()"
-- snippet `` "Prime" iA
--  \\prime
-- endsnippet
--
--
-- # Letters
--
-- context "math()"
-- snippet @p "pi" iA
-- \pi
-- endsnippet
--
-- context "math()"
-- snippet @P "Pi" iA
-- \Pi
-- endsnippet
--
-- context "math()"
-- snippet @g "gamma" iA
-- \gamma
-- endsnippet
--
-- context "math()"
-- snippet @G "Gamma" iA
-- \Gamma
-- endsnippet
--
-- context "math()"
-- snippet @s "sigma" iA
-- \sigma
-- endsnippet
--
-- context "math()"
-- snippet @S "Sigma" iA
-- \Sigma
-- endsnippet
--
-- context "math()"
-- snippet @t "theta" iA
-- \theta
-- endsnippet
--
-- context "math()"
-- snippet @T "Theta" iA
-- \Theta
-- endsnippet
--
-- context "math()"
-- snippet @b "beta" iA
-- \beta
-- endsnippet
--
-- context "math()"
-- snippet @B "Beta" iA
-- \Beta
-- endsnippet
--
-- context "math()"
-- snippet @a "alpha" iA
-- \alpha
-- endsnippet
--
-- context "math()"
-- snippet @A "Alpha" iA
-- \Alpha
-- endsnippet
--
-- context "math()"
-- snippet @l "lambda" iA
-- \lambda
-- endsnippet
--
-- context "math()"
-- snippet @L "Lambda" iA
-- \Lambda
-- endsnippet
--
-- context "math()"
-- snippet @e "epsilon" iA
-- \epsilon
-- endsnippet
--
-- context "math()"
-- snippet @E "Epsilon" iA
-- \Epsilon
-- endsnippet
--
-- context "math()"
-- snippet @d "delta" iA
-- \delta
-- endsnippet
--
-- context "math()"
-- snippet @D "Delta" iA
-- \Delta
-- endsnippet
--
-- context "math()"
-- snippet @f "phi" iA
-- \phi
-- endsnippet
--
-- context "math()"
-- snippet @F "Phi" iA
-- \Phi
-- endsnippet
--
-- context "math()"
-- snippet @r "rho" iA
-- \rho
-- endsnippet
--
-- context "math()"
-- snippet @m "mu" iA
-- \mu
-- endsnippet

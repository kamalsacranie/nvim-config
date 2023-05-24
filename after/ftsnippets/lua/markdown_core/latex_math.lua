-- For some unknown reason, we are also matching inline math blocks...
local tsh = require("utils.treesitter-helpers")
local is_math = function()
	if tsh.is_child_of_node("inline_formula") then
		return true
	end
	if vim.bo.filetype ~= "markdown" then
		return false
	end
	local _, line_number, _, _ = unpack(vim.fn.getpos("."))
	local line = vim.fn.getline(line_number)
	local begins, ends = 0, 0
	while line_number ~= 0 do
		if line:match("\\begin") then
			begins = begins + 1
		end
		if line:match("\\end") then
			ends = ends + 1
		end
		line_number = line_number - 1
		line = vim.fn.getline(line_number)
	end
	if begins - ends == 0 then
		return false
	end
	return true
end

-- local ms = function(params, nodes)
-- 	local all_nodes = {
-- 		f(function(_, snip)
-- 			return snip.captures[1]
-- 		end),
-- 		unpack(nodes),
-- 	}
--
-- 	local all_params = {
-- 		trig = [[(.*)]] .. params["trig"],
-- 		regTrig = true,
-- 		snippetType = "autosnippet",
-- 	}
-- 	return s(all_params, all_nodes, { condition = is_math })
-- end

local spaced_operator = function(trig, delim)
	return s({
		trig = [[(.*)]] .. trig,
		regTrig = true,
		snippetType = "autosnippet",
	}, {
		f(function(_, snip)
			local ends_with = function(str, delim)
				return str:sub(-delim:len()) == delim
			end
			local ends_with_delim = function(str)
				local delims = { "+", "-", "=", [[\times]] }
				local delim_results = vim.tbl_map(function(delim)
					return ends_with(str, delim .. " ")
				end, delims)
				return vim.tbl_contains(delim_results, true)
			end

			local cap = snip.captures[1]
			local prev_char = cap:sub(-1)
			local _, line_number, _, _ = unpack(vim.fn.getpos("."))
			local column_number = 0 -- relative offset in the following func
			local next_char = unpack(
				vim.api.nvim_buf_get_text(
					0,
					line_number - 1,
					column_number,
					line_number - 1,
					column_number + 1,
					{}
				)
			)
			if ends_with_delim(cap) and delim ~= "=" then
				return cap .. delim
			end
			if
				(prev_char == "" or prev_char:match("%s"))
				and (
					next_char == ""
					or next_char:match("%S")
					or next_char:match("%s")
				)
			then
				return cap .. delim .. " "
			elseif
				prev_char:match("%S")
				and (next_char == "" or next_char:match("%S"))
			then
				return cap .. " " .. delim .. " "
			elseif prev_char:match("%S") and next_char:match("%s") then
				return cap .. " " .. delim
			elseif prev_char:match("%s") and next_char:match("%s") then
				return cap .. delim
			end
		end),
	}, { condition = is_math })
end

return {
	s(
		{ trig = "real", description = "Real number symbol" },
		{ t([[\mathbb{R}]]) },
		{
			condition = is_math,
		}
	),
},
	{
		s(
			{ trig = "lim", description = "Limit" },
			fmta([[\mathrm{lim}_{<> \rightarrow <>}]], { i(1), i(2) }),
			{
				condition = is_math,
			}
		),
		s({ trig = "(.*)sq", regTrig = true, description = "Exponential 2" }, {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t([[^2]]),
		}, {
			condition = is_math,
		}),
		spaced_operator("-", "-"),
		spaced_operator("+", "+"),
		spaced_operator("=", "="),
		spaced_operator("%*%*", [[\times]]),
		s({
			trig = "(.*)_",
			regTrig = true,
			description = "subscript",
		}, {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("_{"),
			i(1),
			t("}"),
		}, {
			condition = is_math,
		}),
		s({
			trig = "(.*)^",
			regTrig = true,
			description = "superscript",
		}, {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("^{"),
			i(1),
			t("}"),
		}, {
			condition = is_math,
		}),
		s(
			{ trig = "frac" },
			fmta(
				[[
              \dfrac{<>}{<>}<>
            ]],
				{ i(1), i(2), i(3) }
			),
			{
				condition = is_math,
			}
		),
		s(
			{ trig = "sum" },
			fmta(
				[[
              \sum_{<>}^{<>}<>
            ]],
				{ i(1), i(2), i(3) }
			),
			{
				condition = is_math,
			}
		),
		s({ trig = "..." }, t([[\dots ]]), {
			condition = is_math,
		}),
		s({ trig = "@b" }, t([[\beta]]), { condition = is_math }),
		s(
			{ trig = "{" },
			{ t([[\{]]), i(1), t([[\}]]) },
			{ condition = is_math }
		),
		s({
			trig = "(.*),",
			regTrig = true,
		}, {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t(", "),
		}, {
			condition = is_math,
		}),
		-- ms(
		-- 	{ trig = "frac" },
		-- 	{ t([[\frac]]), t("{"), i(1), t("}"), t("{"), i(2), t("}") }
		-- ),
		-- ms({ trig = "text" }, { t([[\text]]), t("{"), lsg.visual(), i(1), t("}") }),
	}

---OLD ULTISNIPS

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

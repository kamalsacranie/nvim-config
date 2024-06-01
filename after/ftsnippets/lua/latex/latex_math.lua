-- For some unknown reason, we are also matching inline math blocks...
local tsh = require("utils.treesitter-helpers")

local is_math = function()
    -- if we are in markdown or quarto we assume always  math. this is not ideal
    -- but i will do this until I encounter a problem
    if vim.filetype.match({ buf = 0 }) == "markdown" then
        return true
    end
    if tsh.is_child_of_node("math_environment") then
        return true
    end
end

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
local greek = {
    { "Alpha",   "A" },
    { "Beta",    "B" },
    { "Gamma",   "G" },
    { "Delta",   "D" },
    { "Epsilon", "Ep" },
    { "Zeta",    "Z" },
    { "Eta",     "E" },
    { "Theta",   "Th" },
    { "Iota",    "I" },
    { "Kappa",   "K" },
    { "Lambda",  "L" },
    { "Mu",      "M" },
    { "Nu",      "N" },
    { "Xi",      "X" },
    { "Omicron", "Om" },
    { "Pi",      "P" },
    { "Rho",     "R" },
    { "Sigma",   "S" },
    { "Tau",     "T" },
    { "Upsilon", "U" },
    { "Phi",     "Ph" },
    { "Chi",     "Kh" },
    { "Psi",     "Ps" },
    { "Omega",   "O" }
}

local upper_greek_snips = vim.tbl_map(function(letter)
        local actual = letter[1]
        local shorthand = letter[2]

        return s(
            {
                trig = "@" .. shorthand,
                description = "Greek letter " .. actual,
                name = "Greek letter " .. actual,
            },
            { t("\\" .. actual) },
            { condition = is_math }
        )
    end,
    greek
)

local lower_greek_snips = vim.tbl_map(function(letter)
        local actual = letter[1]:lower()
        local shorthand = letter[2]:lower()

        return s(
            {
                trig = "@" .. shorthand,
                regTrig = false,
                name = "Greek letter " .. actual,
                description = "Greek letter " .. actual
            },
            { t("\\" .. actual) },
            { condition = is_math }
        )
    end,
    greek
)

return {
        s(
            { trig = "real", description = "Real number symbol" },
            { t([[\mathbb{R}]]) },
            {
                condition = is_math,
            }
        ),
        unpack(lower_greek_snips),
        unpack(upper_greek_snips),
    },
    {
        s(
            { trig = "lim", description = "Limit" },
            fmta([[\mathrm{lim}_{<> \rightarrow <>}]], { i(1), i(2) }),
            {
                condition = is_math,
            }
        ),
        s(
            { trig = "rarr", description = "Right arrow" },
            { t([[\rightarrow ]]) },
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
        spaced_operator("<=", [[\leq]]),
        spaced_operator(">=", [[\geq]]),
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
        s(
            { trig = "text", name = "Math text node" },
            { t([[\text{]]), i(1), t([[}]]) },
            { condition = is_math }
        )
    }

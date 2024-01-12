local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
    aub = function(params, nodes, opts)
        return s(
            vim.tbl_extend("force", params,
                { snippetType = "autosnippet" }),
            nodes,
            {
                condition = require(
                        "luasnip.extras.conditions.expand")
                    .line_begin
            }
        )
    end,
    visual = function()
        -- returns a function snippet which returns the current visual selection
        return f(function(_, snip)
            local visual = snip.env.LS_SELECT_RAW
            if type(visual) == "string" then
                return ""
            end
            return visual
        end)
    end,
    midword = function(conf, nodes)
        -- Returns a snippet which expands mid line
        local s = require("luasnip").s
        local f = require("luasnip").f
        return s(
            vim.tbl_extend(
                "keep",
                { trig = "(.*)" .. conf["trig"], regTrig = true },
                conf
            ),
            vim.list_extend(
                { f(function(_, snip)
                    return snip.captures[1]
                end) },
                nodes
            )
        )
    end,
}

require("luasnip.extras.conditions.expand")
local ts_utils = require("nvim-treesitter.ts_utils")

--- Checks if node is a child of a specified parent node at any point in its preceeding tree
---@param parent_node_type string The name of the parent node to match against
---@return boolean
local is_child_of_node = function(parent_node_type)
	local cursor_node = ts_utils.get_node_at_cursor()
	if not cursor_node then
		return false
	end
	local comparison_nodes =
		require("utils.treesitter-helpers").get_all_parent_nodes(cursor_node)
	table.insert(comparison_nodes, cursor_node)
	comparison_nodes = vim.tbl_map(function(node)
		return node:type()
	end, comparison_nodes)
	if vim.tbl_contains(comparison_nodes, parent_node_type) then
		print("wtf")
		return true
	end
	return false
end
local conds = require("luasnip.extras.conditions.expand")

return {
	s(
		{ trig = "impo?r?t?", name = "Import statement", regTrig = true },
		fmta( -- should use a functional snippet for * automatic adding as {}
			[[
                import <> from "<>"
                ]],
			{ i(2), i(1) }
		),
		{ condition = conds.line_begin }
	),
	s(
		{
			trig = "(.*)ts",
			name = "Template substitution",
			regTrig = true,
		},
		fmta(
			"<>${<>}",
			{ f(function(_, snip)
				return snip.captures[1]
			end), i(1) }
			-- "${<>}",
			-- { i(1) }
		),
		{
			condition = function()
				return is_child_of_node("template_string")
			end,
		}
	),
}

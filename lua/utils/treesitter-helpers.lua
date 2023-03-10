local M = {}
local ts_utils = require("nvim-treesitter.ts_utils")

--- Returns a list-like table for all the parent nodes of a node
---@param node TSNode a tree-sitter node
---@return TSNode[] a list of tree-sitter nodes
M.get_all_parent_nodes = function(node)
	local result = {}
	local immediate_parent = node:parent() or nil
	if not immediate_parent then
		return result
	end
	table.insert(result, immediate_parent)
	local ancestors = M.get_all_parent_nodes(immediate_parent)
	for _, parent in ipairs(ancestors) do
		table.insert(result, parent)
	end
	return result
end

--- Checks if node is a child of a specified parent node at any point in its preceeding tree
---@param parent_node_type string The name of the parent node to match against
---@return boolean
M.is_child_of_node = function(parent_node_type)
	local cursor_node = ts_utils.get_node_at_cursor()
	if not cursor_node then
		return false
	end
	local comparison_nodes = M.get_all_parent_nodes(cursor_node)
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

return M
